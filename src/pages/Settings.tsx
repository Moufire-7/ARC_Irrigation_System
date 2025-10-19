import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { toast } from "sonner";

export default function Settings() {
  const handleTestConnection = () => {
    toast.success("Connection test successful", {
      description: "LoRa network connected at 433 MHz",
    });
  };

  const handleSync = () => {
    toast.success("Sync completed", {
      description: "Latest data retrieved from API",
    });
  };

  return (
    <div className="space-y-6 md:ml-56">
      <div>
        <h2 className="text-3xl font-bold text-foreground mb-2">System Settings</h2>
        <p className="text-muted-foreground">Configure your irrigation system</p>
      </div>

      {/* LoRa Network Configuration */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-6">LoRa Network Configuration</h3>
        <div className="space-y-4">
          <div>
            <Label htmlFor="frequency">Frequency (MHz)</Label>
            <Input id="frequency" type="number" defaultValue="433" className="mt-1" />
          </div>
          <div>
            <Label htmlFor="networkId">Network ID</Label>
            <Input id="networkId" defaultValue="1234567890" className="mt-1" />
          </div>
          <div>
            <Label htmlFor="spreading">Spreading Factor</Label>
            <Select defaultValue="SF7">
              <SelectTrigger id="spreading" className="mt-1">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="SF7">SF7</SelectItem>
                <SelectItem value="SF8">SF8</SelectItem>
                <SelectItem value="SF9">SF9</SelectItem>
                <SelectItem value="SF10">SF10</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <Button onClick={handleTestConnection} className="w-full md:w-auto">
            Test Connection
          </Button>
        </div>
      </Card>

      {/* API Endpoint */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-6">API Endpoint</h3>
        <div className="space-y-4">
          <div>
            <Label htmlFor="apiUrl">API URL</Label>
            <Input
              id="apiUrl"
              defaultValue="https://api.irrigation.uwc.ac.za"
              className="mt-1"
            />
          </div>
          <div>
            <Label htmlFor="apiKey">API Key</Label>
            <Input
              id="apiKey"
              type="password"
              defaultValue="••••••••••••••"
              className="mt-1"
            />
          </div>
          <div>
            <Label htmlFor="syncInterval">Sync Interval (minutes)</Label>
            <Input id="syncInterval" type="number" defaultValue="15" className="mt-1" />
          </div>
          <Button onClick={handleSync} className="w-full md:w-auto">
            Sync Now
          </Button>
        </div>
      </Card>

      {/* General Settings */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-6">General Settings</h3>
        <div className="space-y-4">
          <div>
            <Label htmlFor="unit">Measurement Unit</Label>
            <Select defaultValue="liters">
              <SelectTrigger id="unit" className="mt-1">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="liters">Liters</SelectItem>
                <SelectItem value="gallons">Gallons</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div>
            <Label htmlFor="theme">Application Theme</Label>
            <Select defaultValue="light">
              <SelectTrigger id="theme" className="mt-1">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="light">Light</SelectItem>
                <SelectItem value="dark">Dark</SelectItem>
                <SelectItem value="auto">Auto</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div>
            <Label htmlFor="language">Language</Label>
            <Select defaultValue="english">
              <SelectTrigger id="language" className="mt-1">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="english">English</SelectItem>
                <SelectItem value="afrikaans">Afrikaans</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
      </Card>

      {/* About */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-4">About</h3>
        <div className="space-y-2 text-sm">
          <div className="flex justify-between">
            <span className="text-muted-foreground">Version:</span>
            <span className="font-medium">1.0.0</span>
          </div>
          <div className="flex justify-between">
            <span className="text-muted-foreground">Group:</span>
            <span className="font-medium">IFS325/353 Group 1</span>
          </div>
          <div className="flex justify-between">
            <span className="text-muted-foreground">University:</span>
            <span className="font-medium">University of the Western Cape</span>
          </div>
          <div className="flex justify-between">
            <span className="text-muted-foreground">Year:</span>
            <span className="font-medium">2025</span>
          </div>
        </div>
        <Button variant="link" className="mt-4 p-0 h-auto text-primary">
          View Documentation
        </Button>
      </Card>
    </div>
  );
}
