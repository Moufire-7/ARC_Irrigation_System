from flask import Flask, render_template_string, request, redirect, url_for
import paho.mqtt.client as mqtt
import threading
import schedule
import time
from datetime import datetime
import pytz

# --- Flask & MQTT Setup ---
app = Flask(__name__)

# --- MQTT Configuration ---
MQTT_BROKER = "192.168.0.104"  # Your MQTT Broker IP
MQTT_PORT = 1883
MQTT_COMMAND_TOPIC = "grp6_irrigation_command"
SAST_TIMEZONE = pytz.timezone('Africa/Johannesburg')

# --- Scheduling State (Global) ---
# We use a dictionary to hold the schedule state so it can be safely shared
schedule_info = {
    "start_str": "Not Set",
    "end_str": "Not Set",
    "active": False,
    "start_dt": None,  # Will hold the full start datetime object
    "end_dt": None  # Will hold the full end datetime object
}

# --- HTML Template with Scheduler ---
html_template = """
<!DOCTYPE html>
<html>
<head>
    <title>Irrigation Control & Scheduler</title>
    <style>
        body { font-family: sans-serif; background-color: #2c3e50; color: #ecf0f1; margin: 0; padding: 20px; }
        .main-container { max-width: 800px; margin: auto; }
        h1 { color: #1abc9c; text-align: center; }
        .container { display: flex; justify-content: space-around; flex-wrap: wrap; gap: 20px; }
        .card { text-align: center; background-color: #34495e; padding: 30px; border-radius: 15px; box-shadow: 0 10px 20px rgba(0,0,0,0.3); flex-basis: 300px; }
        h2 { color: #1abc9c; border-bottom: 2px solid #16a085; padding-bottom: 10px; }
        button, input[type=submit] { border: none; padding: 15px 30px; margin: 10px; border-radius: 10px; cursor: pointer; font-size: 1.1em; font-weight: bold; transition: transform 0.2s, box-shadow 0.2s; }
        button:active, input[type=submit]:active { transform: scale(0.95); }
        #btnOn { background-color: #2ecc71; color: white; box-shadow: 0 5px #27ae60; }
        #btnOff { background-color: #e74c3c; color: white; box-shadow: 0 5px #c0392b; }
        .schedule-form input { width: calc(100% - 20px); padding: 10px; margin-bottom: 10px; border-radius: 5px; border: none; }
        .status { background-color: #27ae60; color: white; padding: 10px; border-radius: 5px; }
        .inactive { background-color: #e74c3c; }
    </style>
</head>
<body>
    <div class="main-container">
        <h1>Irrigation Control & Scheduler</h1>
        <div class="container">
            <div class="card">
                <h2>Manual Control</h2>
                <form action="/turn_on" method="post" style="display:inline;">
                    <button id="btnOn" type="submit">TURN PUMP ON</button>
                </form>
                <form action="/turn_off" method="post" style="display:inline;">
                    <button id="btnOff" type="submit">TURN PUMP OFF</button>
                </form>
            </div>

            <div class="card">
                <h2>Scheduler</h2>
                <div class="schedule-form">
                    <form action="/set_schedule" method="post">
                        <label for="start_date">Date:</label>
                        <input type="date" id="start_date" name="start_date" required>
                        <label for="start_time">Start Time:</label>
                        <input type="time" id="start_time" name="start_time" required>
                        <label for="end_time">End Time:</label>
                        <input type="time" id="end_time" name="end_time" required>
                        <input type="submit" value="Set Schedule" style="background-color: #3498db; color: white; box-shadow: 0 5px #2980b9;">
                    </form>
                    <form action="/cancel_schedule" method="post">
                        <input type="submit" value="Cancel Schedule" style="background-color: #f39c12; color: white; box-shadow: 0 5px #d35400;">
                    </form>
                </div>
            </div>
        </div>
        <div class="card" style="margin-top: 20px;">
            <h2>Current Schedule Status</h2>
            <p class="status {{ 'inactive' if not schedule_active }}">
                {{ 'ACTIVE' if schedule_active else 'INACTIVE' }}
            </p>
            <p><strong>Start:</strong> {{ start_time }}</p>
            <p><strong>End:</strong> {{ end_time }}</p>
        </div>
    </div>
</body>
</html>
"""

# --- MQTT Client Setup ---
mqtt_client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)


# --- Core MQTT Functions (Do ONE thing) ---
def publish_pump_on():
    """Publishes the ON command."""
    print(f"[{datetime.now()}] MQTT: Publishing ON")
    mqtt_client.publish(MQTT_COMMAND_TOPIC, "ON")


def publish_pump_off():
    """Publishes the OFF command."""
    print(f"[{datetime.now()}] MQTT: Publishing OFF")
    mqtt_client.publish(MQTT_COMMAND_TOPIC, "OFF")


# --- Scheduler Job Functions ---
def scheduled_turn_on():
    """Scheduled job to turn pump ON. Checks date first."""
    now = datetime.now(SAST_TIMEZONE)

    # Check if a schedule is active and today is the correct date
    if schedule_info['active'] and schedule_info['start_dt'] and now.date() == schedule_info['start_dt'].date():
        print(f"[{datetime.now()}] SCHEDULE: Correct date. Turning pump ON.")
        publish_pump_on()
    else:
        print(f"[{datetime.now()}] SCHEDULE: Skipping ON job (Wrong date or inactive).")


def scheduled_turn_off():
    """Scheduled job to turn pump OFF. Checks date and cleans up schedule."""
    now = datetime.now(SAST_TIMEZONE)

    # Check if a schedule is active and today is the correct date
    if schedule_info['active'] and schedule_info['end_dt'] and now.date() == schedule_info['end_dt'].date():
        print(f"[{datetime.now()}] SCHEDULE: Correct date. Turning pump OFF.")
        publish_pump_off()

        # Job is done, set schedule to inactive and clear all 'irrigation' jobs
        print(f"[{datetime.now()}] SCHEDULE: Job complete. Clearing schedule.")
        schedule_info['active'] = False
        schedule.clear('irrigation')

    # If the target date is now in the past, clean up the schedule
    elif schedule_info['end_dt'] and schedule_info['end_dt'] < now:
        print(f"[{datetime.now()}] SCHEDULE: Target date is in the past. Clearing schedule.")
        schedule_info['active'] = False
        schedule.clear('irrigation')
    else:
        print(f"[{datetime.now()}] SCHEDULE: Skipping OFF job (Wrong date or inactive).")


def setup_mqtt():
    """Connects the backend to the MQTT broker."""
    try:
        mqtt_client.connect(MQTT_BROKER, MQTT_PORT, 60)
        mqtt_client.loop_start()
        print("Successfully connected to MQTT broker.")
    except Exception as e:
        print(f"Error connecting to MQTT broker: {e}")


def run_scheduler():
    """The background thread function that runs pending scheduled jobs."""
    while True:
        schedule.run_pending()
        time.sleep(1)


# --- Flask Web Routes ---
@app.route('/')
def index():
    """Serves the main HTML page with current schedule status."""
    # Reset display if schedule is no longer active
    if not schedule_info['active']:
        schedule_info['start_str'] = "Not Set"
        schedule_info['end_str'] = "Not Set"

    return render_template_string(
        html_template,
        schedule_active=schedule_info['active'],
        start_time=schedule_info['start_str'],
        end_time=schedule_info['end_str']
    )


@app.route('/turn_on', methods=['POST'])
def manual_on():
    print("Received MANUAL command: ON. Cancelling any active schedule.")
    schedule.clear()  # Cancel all scheduled jobs
    schedule_info['active'] = False
    publish_pump_on()  # Turn pump on immediately
    return redirect(url_for('index'))


@app.route('/turn_off', methods=['POST'])
def manual_off():
    print("Received MANUAL command: OFF. Cancelling any active schedule.")
    schedule.clear()
    schedule_info['active'] = False
    publish_pump_off()  # Turn pump off immediately
    return redirect(url_for('index'))


@app.route('/set_schedule', methods=['POST'])
def set_schedule():
    """Receives form data and sets up the scheduled jobs."""
    date = request.form['start_date']
    start_time = request.form['start_time']
    end_time = request.form['end_time']

    # Combine date and time strings and convert to timezone-aware datetime objects
    start_dt_str = f"{date} {start_time}"
    end_dt_str = f"{date} {end_time}"

    try:
        start_dt = SAST_TIMEZONE.localize(datetime.strptime(start_dt_str, "%Y-%m-%d %H:%M"))
        end_dt = SAST_TIMEZONE.localize(datetime.strptime(end_dt_str, "%Y-%m-%d %H:%M"))
    except ValueError:
        print("Error: Invalid date/time format.")
        return redirect(url_for('index'))

    now = datetime.now(SAST_TIMEZONE)

    if start_dt < now:
        print("Error: Scheduled start time is in the past.")
        return redirect(url_for('index'))
    if end_dt <= start_dt:
        print("Error: End time must be after start time.")
        return redirect(url_for('index'))

    # Clear any previous schedule
    schedule.clear()

    # Store full datetime info for the job functions to check
    schedule_info['start_dt'] = start_dt
    schedule_info['end_dt'] = end_dt
    schedule_info['start_str'] = start_dt.strftime("%Y-%m-%d %H:%M")
    schedule_info['end_str'] = end_dt.strftime("%Y-%m-%d %H:%M")
    schedule_info['active'] = True

    # Schedule the jobs to check every day at the given times
    # The jobs themselves will decide if it's the right day to run.
    schedule.every().day.at(start_time).do(scheduled_turn_on).tag('irrigation')
    schedule.every().day.at(end_time).do(scheduled_turn_off).tag('irrigation')

    print(f"Schedule set: ON at {start_dt_str}, OFF at {end_dt_str}")
    return redirect(url_for('index'))


@app.route('/cancel_schedule', methods=['POST'])
def cancel_schedule():
    """Cancels all scheduled jobs and turns the pump off."""
    print("Received command: CANCEL SCHEDULE. Turning pump off.")
    schedule.clear()
    schedule_info['active'] = False
    publish_pump_off()  # Ensure pump is turned off
    return redirect(url_for('index'))


# --- Main Execution ---
if __name__ == '__main__':
    setup_mqtt()
    # Start the scheduler in a background thread
    scheduler_thread = threading.Thread(target=run_scheduler, daemon=True)
    scheduler_thread.start()
    app.run(host='0.0.0.0', port=5000)