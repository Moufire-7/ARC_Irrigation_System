import { Card } from "@/components/ui/card";
import { StatCard } from "@/components/StatCard";
import { Droplets, TrendingUp, Activity } from "lucide-react";
import {
  LineChart,
  Line,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from "recharts";

const weeklyData = [
  { day: "Mon", usage: 10, scheduled: 12 },
  { day: "Tue", usage: 15, scheduled: 14 },
  { day: "Wed", usage: 20, scheduled: 18 },
  { day: "Thu", usage: 18, scheduled: 16 },
  { day: "Fri", usage: 22, scheduled: 20 },
  { day: "Sat", usage: 25, scheduled: 22 },
  { day: "Sun", usage: 45, scheduled: 40 },
];

const trendData = [
  { time: "00:00", flow: 0 },
  { time: "04:00", flow: 0 },
  { time: "08:00", flow: 2.8 },
  { time: "12:00", flow: 0 },
  { time: "16:00", flow: 0 },
  { time: "20:00", flow: 0 },
  { time: "23:59", flow: 0 },
];

export default function Statistics() {
  return (
    <div className="space-y-6 md:ml-56">
      <div>
        <h2 className="text-3xl font-bold text-foreground mb-2">Water Usage Statistics</h2>
        <p className="text-muted-foreground">Analyze your irrigation efficiency and patterns</p>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <StatCard
          title="Average Flow Rate"
          value="2.3"
          unit="L/min"
          icon={Droplets}
          trend={{ value: 8, isPositive: true }}
        />
        <StatCard
          title="Total This Week"
          value="155"
          unit="liters"
          icon={TrendingUp}
          trend={{ value: 12, isPositive: true }}
        />
        <StatCard
          title="Efficiency"
          value="94"
          unit="%"
          icon={Activity}
          trend={{ value: 3, isPositive: true }}
        />
      </div>

      {/* Water Usage Trend */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-6">Water Usage Trend</h3>
        <ResponsiveContainer width="100%" height={300}>
          <LineChart data={weeklyData}>
            <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" />
            <XAxis dataKey="day" stroke="hsl(var(--muted-foreground))" />
            <YAxis stroke="hsl(var(--muted-foreground))" />
            <Tooltip
              contentStyle={{
                backgroundColor: "hsl(var(--card))",
                border: "1px solid hsl(var(--border))",
                borderRadius: "8px",
              }}
            />
            <Legend />
            <Line
              type="monotone"
              dataKey="usage"
              stroke="hsl(var(--primary))"
              strokeWidth={3}
              dot={{ fill: "hsl(var(--primary))", r: 5 }}
              name="Actual Usage (L)"
            />
          </LineChart>
        </ResponsiveContainer>
      </Card>

      {/* Scheduled vs Actual */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-6">Scheduled vs Actual Irrigation</h3>
        <ResponsiveContainer width="100%" height={300}>
          <BarChart data={weeklyData}>
            <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" />
            <XAxis dataKey="day" stroke="hsl(var(--muted-foreground))" />
            <YAxis stroke="hsl(var(--muted-foreground))" />
            <Tooltip
              contentStyle={{
                backgroundColor: "hsl(var(--card))",
                border: "1px solid hsl(var(--border))",
                borderRadius: "8px",
              }}
            />
            <Legend />
            <Bar dataKey="scheduled" fill="hsl(var(--muted))" name="Scheduled (L)" radius={[8, 8, 0, 0]} />
            <Bar dataKey="usage" fill="hsl(var(--primary))" name="Actual (L)" radius={[8, 8, 0, 0]} />
          </BarChart>
        </ResponsiveContainer>
      </Card>

      {/* Irrigation Events Table */}
      <Card className="p-6">
        <h3 className="text-lg font-semibold mb-4">Irrigation Events</h3>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-border">
              <tr className="text-left">
                <th className="pb-3 font-semibold text-muted-foreground">Date</th>
                <th className="pb-3 font-semibold text-muted-foreground">Time</th>
                <th className="pb-3 font-semibold text-muted-foreground">Duration</th>
                <th className="pb-3 font-semibold text-muted-foreground">Volume</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border">
              {[
                { date: "2025-10-30", time: "08:00", duration: "15 min", volume: "25 liters" },
                { date: "2025-10-29", time: "08:00", duration: "15 min", volume: "22 liters" },
                { date: "2025-10-28", time: "08:00", duration: "15 min", volume: "18 liters" },
                { date: "2025-10-27", time: "08:00", duration: "15 min", volume: "20 liters" },
              ].map((event, i) => (
                <tr key={i} className="hover:bg-muted/50">
                  <td className="py-3">{event.date}</td>
                  <td className="py-3">{event.time}</td>
                  <td className="py-3">{event.duration}</td>
                  <td className="py-3 font-semibold">{event.volume}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </Card>
    </div>
  );
}
