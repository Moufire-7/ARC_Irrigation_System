import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Switch } from "@/components/ui/switch";
import { AlertCircle, CheckCircle, Wrench, Droplet, X } from "lucide-react";
import { toast } from "sonner";

const alerts = [
  {
    id: 1,
    type: "warning",
    title: "Low flow detected at 2:00 PM",
    description: "Flow rate dropped below 1.5 L/min",
    time: "2 hours ago",
    read: false,
  },
  {
    id: 2,
    type: "info",
    title: "Maintenance due in 3 days",
    description: "Scheduled pump maintenance reminder",
    time: "5 hours ago",
    read: false,
  },
  {
    id: 3,
    type: "success",
    title: "Irrigation completed successfully",
    description: "Morning schedule finished. 25L used.",
    time: "Today at 08:15 AM",
    read: true,
  },
];

const getIcon = (type: string) => {
  switch (type) {
    case "warning":
      return <Droplet className="w-5 h-5 text-warning" />;
    case "info":
      return <Wrench className="w-5 h-5 text-primary" />;
    case "success":
      return <CheckCircle className="w-5 h-5 text-success" />;
    default:
      return <AlertCircle className="w-5 h-5" />;
  }
};

export default function Alerts() {
  const handleMarkAllRead = () => {
    toast.success("All alerts marked as read");
  };

  const handleDismiss = (id: number) => {
    toast.success("Alert dismissed");
  };

  return (
    <div className="space-y-6 md:ml-56">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-3xl font-bold text-foreground mb-2">Alerts</h2>
          <p className="text-muted-foreground">System notifications and maintenance reminders</p>
        </div>
        <Button variant="outline" onClick={handleMarkAllRead}>
          Mark all as read
        </Button>
      </div>

      {/* Notification Settings */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-4">Notification Settings</h3>
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="font-medium">Low Flow Rate Alerts</p>
              <p className="text-sm text-muted-foreground">
                Get notified when flow rate drops below threshold
              </p>
            </div>
            <Switch defaultChecked />
          </div>
          <div className="flex items-center justify-between">
            <div>
              <p className="font-medium">Maintenance Reminders</p>
              <p className="text-sm text-muted-foreground">
                Receive periodic maintenance notifications
              </p>
            </div>
            <Switch defaultChecked />
          </div>
        </div>
      </Card>

      {/* Alerts List */}
      <div className="space-y-3">
        {alerts.map((alert) => (
          <Card
            key={alert.id}
            className={`p-4 ${!alert.read ? "border-l-4 border-l-primary" : ""}`}
          >
            <div className="flex items-start gap-4">
              <div className="mt-1">{getIcon(alert.type)}</div>
              <div className="flex-1">
                <div className="flex items-start justify-between mb-2">
                  <div>
                    <h4 className="font-semibold text-foreground">{alert.title}</h4>
                    <p className="text-sm text-muted-foreground mt-1">{alert.description}</p>
                  </div>
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={() => handleDismiss(alert.id)}
                    className="ml-2"
                  >
                    <X className="w-4 h-4" />
                  </Button>
                </div>
                <div className="flex items-center gap-4 mt-3">
                  <span className="text-xs text-muted-foreground">{alert.time}</span>
                  {!alert.read && (
                    <Button variant="link" size="sm" className="h-auto p-0 text-xs">
                      Mark as read
                    </Button>
                  )}
                </div>
              </div>
            </div>
          </Card>
        ))}
      </div>

      {/* Alert History */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-4">Alert History</h3>
        <div className="space-y-2">
          {[
            "System check completed - Oct 29",
            "Low battery warning cleared - Oct 28",
            "Pump activated remotely - Oct 27",
            "Schedule updated - Oct 26",
          ].map((item, i) => (
            <div
              key={i}
              className="flex items-center gap-3 p-3 hover:bg-muted/50 rounded-lg transition-colors"
            >
              <CheckCircle className="w-4 h-4 text-muted-foreground" />
              <p className="text-sm text-muted-foreground">{item}</p>
            </div>
          ))}
        </div>
      </Card>
    </div>
  );
}
