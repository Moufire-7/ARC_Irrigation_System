import { useState } from "react";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Switch } from "@/components/ui/switch";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Plus, Cloud } from "lucide-react";
import { toast } from "sonner";

export default function Schedules() {
  const [automationEnabled, setAutomationEnabled] = useState(false);

  const handleAutomationToggle = () => {
    setAutomationEnabled(!automationEnabled);
    toast.success(
      automationEnabled ? "Automation disabled" : "Automation enabled",
      {
        description: automationEnabled
          ? "Switched to manual scheduling"
          : "System will respond to soil moisture data",
      }
    );
  };

  return (
    <div className="space-y-6 md:ml-56">
      <div>
        <h2 className="text-3xl font-bold text-foreground mb-2">Irrigation Schedules</h2>
        <p className="text-muted-foreground">Manage automated and scheduled irrigation</p>
      </div>

      {/* Soil Moisture Automation */}
      <Card className="p-6">
        <div className="flex items-start justify-between mb-4">
          <div className="flex items-center gap-3">
            <Cloud className="w-6 h-6 text-primary" />
            <div>
              <h3 className="text-lg font-semibold">Soil Moisture Automation</h3>
              <p className="text-sm text-muted-foreground">
                Enable to automatically irrigate based on soil moisture data
              </p>
            </div>
          </div>
          <Switch checked={automationEnabled} onCheckedChange={handleAutomationToggle} />
        </div>
        {automationEnabled && (
          <div className="mt-4 p-4 bg-success/10 border border-success/20 rounded-lg">
            <p className="text-sm text-success-foreground">
              ✓ Connected to Group 2 soil moisture sensor
            </p>
            <p className="text-xs text-muted-foreground mt-1">
              Current soil moisture: 45% • Threshold: 40%
            </p>
          </div>
        )}
      </Card>

      {/* Add New Schedule */}
      <Card className="p-6">
        <div className="flex items-center justify-between mb-6">
          <h3 className="text-lg font-semibold">Scheduled Irrigation</h3>
          <Button>
            <Plus className="w-4 h-4 mr-2" />
            Add New
          </Button>
        </div>

        <div className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <Label htmlFor="time">Start Time</Label>
              <Input id="time" type="time" defaultValue="08:00" className="mt-1" />
            </div>
            <div>
              <Label htmlFor="duration">Duration (minutes)</Label>
              <Input id="duration" type="number" defaultValue="15" className="mt-1" />
            </div>
          </div>

          <div>
            <Label htmlFor="frequency">Frequency</Label>
            <Select defaultValue="daily">
              <SelectTrigger id="frequency" className="mt-1">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="daily">Daily</SelectItem>
                <SelectItem value="weekly">Weekly</SelectItem>
                <SelectItem value="custom">Custom</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
      </Card>

      {/* Schedule Settings */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-4">Schedule Settings</h3>
        <div className="space-y-4">
          <div>
            <Label htmlFor="maxDuration">Maximum Duration (minutes)</Label>
            <Input id="maxDuration" type="number" defaultValue="60" className="mt-1" />
          </div>
          <div>
            <Label htmlFor="defaultFreq">Default Frequency</Label>
            <Select defaultValue="daily">
              <SelectTrigger id="defaultFreq" className="mt-1">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="daily">Daily</SelectItem>
                <SelectItem value="weekly">Weekly</SelectItem>
                <SelectItem value="biweekly">Bi-weekly</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
      </Card>

      {/* Active Schedules */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-4">Active Schedules</h3>
        <div className="space-y-3">
          <div className="flex items-center justify-between p-4 bg-primary/5 border border-primary/20 rounded-lg">
            <div className="flex-1">
              <div className="flex items-center gap-2 mb-1">
                <p className="font-semibold">Morning Irrigation</p>
                <span className="text-xs px-2 py-0.5 bg-success/20 text-success rounded-full">
                  Active
                </span>
              </div>
              <p className="text-sm text-muted-foreground">08:00 • 15 minutes • Daily</p>
              <p className="text-xs text-muted-foreground mt-1">Next run: Tomorrow at 08:00 AM</p>
            </div>
            <Switch defaultChecked />
          </div>

          <div className="flex items-center justify-between p-4 bg-muted/30 border border-border rounded-lg opacity-60">
            <div className="flex-1">
              <div className="flex items-center gap-2 mb-1">
                <p className="font-semibold">Evening Irrigation</p>
                <span className="text-xs px-2 py-0.5 bg-muted text-muted-foreground rounded-full">
                  Disabled
                </span>
              </div>
              <p className="text-sm text-muted-foreground">18:00 • 20 minutes • Daily</p>
            </div>
            <Switch />
          </div>
        </div>
      </Card>
    </div>
  );
}
