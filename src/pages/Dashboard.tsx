import { useState, useEffect } from "react";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Switch } from "@/components/ui/switch";
import { CircularProgress } from "@/components/CircularProgress";
import { StatCard } from "@/components/StatCard";
import { Droplets, Power, Activity, Calendar } from "lucide-react";
import { toast } from "sonner";

export default function Dashboard() {
  const [isPumpActive, setIsPumpActive] = useState(true);
  const [flowRate, setFlowRate] = useState(2.5);
  const [totalUsage, setTotalUsage] = useState(45.0);
  const dailyGoal = 100;

  // Simulate real-time updates
  useEffect(() => {
    const interval = setInterval(() => {
      if (isPumpActive) {
        setFlowRate((prev) => Math.max(1.5, Math.min(4.0, prev + (Math.random() - 0.5) * 0.3)));
        setTotalUsage((prev) => prev + 0.05);
      } else {
        setFlowRate(0);
      }
    }, 5000);

    return () => clearInterval(interval);
  }, [isPumpActive]);

  const handlePumpToggle = () => {
    setIsPumpActive(!isPumpActive);
    toast.success(
      isPumpActive ? "Pump deactivated" : "Pump activated",
      { description: isPumpActive ? "Irrigation stopped" : "Irrigation started" }
    );
  };

  return (
    <div className="space-y-6 md:ml-56">
      <div>
        <h2 className="text-3xl font-bold text-foreground mb-2">Irrigation Dashboard</h2>
        <p className="text-muted-foreground">Monitor and control your smart irrigation system</p>
      </div>

      {/* System Status */}
      <Card className="p-6">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h3 className="text-lg font-semibold text-foreground">System Status</h3>
            <p className="text-sm text-muted-foreground">Irrigation Status</p>
          </div>
          <div
            className={`px-4 py-2 rounded-full font-semibold ${
              isPumpActive ? "bg-success/20 text-success" : "bg-muted text-muted-foreground"
            }`}
          >
            {isPumpActive ? "Active" : "Inactive"}
          </div>
        </div>
      </Card>

      {/* Daily Water Usage */}
      <Card className="p-8 flex justify-center">
        <div className="relative">
          <CircularProgress value={totalUsage} max={dailyGoal} size={240} />
        </div>
      </Card>

      {/* Real-time Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <StatCard
          title="Current Flow Rate"
          value={flowRate.toFixed(1)}
          unit="L/min"
          icon={Droplets}
        />
        <StatCard
          title="Total Water Used"
          value={totalUsage.toFixed(1)}
          unit="liters"
          icon={Activity}
        />
      </div>

      {/* Pump Control */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-4">Pump Control</h3>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-3">
            <Power className={`w-6 h-6 ${isPumpActive ? "text-success" : "text-muted-foreground"}`} />
            <div>
              <p className="font-medium">Manual Control</p>
              <p className="text-sm text-muted-foreground">Toggle pump on/off</p>
            </div>
          </div>
          <Switch checked={isPumpActive} onCheckedChange={handlePumpToggle} />
        </div>
      </Card>

      {/* Quick Actions */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-4">Quick Actions</h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
          <Button variant="outline" className="justify-start">
            <Power className="w-4 h-4 mr-2" />
            Start Manual Irrigation
          </Button>
          <Button variant="outline" className="justify-start">
            <Calendar className="w-4 h-4 mr-2" />
            View Today's Schedule
          </Button>
          <Button variant="outline" className="justify-start">
            <Activity className="w-4 h-4 mr-2" />
            Check System Health
          </Button>
        </div>
      </Card>

      {/* Today's Schedule Preview */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-4">Today's Schedule</h3>
        <div className="space-y-3">
          <div className="flex items-center justify-between p-3 bg-muted/50 rounded-lg">
            <div>
              <p className="font-medium">Morning Irrigation</p>
              <p className="text-sm text-muted-foreground">08:00 AM • 15 minutes</p>
            </div>
            <span className="text-xs px-2 py-1 bg-success/20 text-success rounded-full">Completed</span>
          </div>
          <div className="flex items-center justify-between p-3 bg-primary/5 border border-primary/20 rounded-lg">
            <div>
              <p className="font-medium">Afternoon Irrigation</p>
              <p className="text-sm text-muted-foreground">Next run: Tomorrow at 08:00 AM</p>
            </div>
            <span className="text-xs px-2 py-1 bg-primary/20 text-primary rounded-full">Daily</span>
          </div>
        </div>
      </Card>
    </div>
  );
}
