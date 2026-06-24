import React, { useEffect, useState } from 'react';
import api from '../api';
import { Activity, Package, AlertTriangle, Clock, TrendingUp, X, HeartPulse, ArrowUpRight, ArrowDownRight } from 'lucide-react';
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar, PieChart, Pie, Cell } from 'recharts';

// Mock Data for Premium Presentation Charts
const inventoryTrendsData = [
  { name: 'Jan', stock: 4000, usage: 2400 },
  { name: 'Feb', stock: 3000, usage: 1398 },
  { name: 'Mar', stock: 2000, usage: 9800 },
  { name: 'Apr', stock: 2780, usage: 3908 },
  { name: 'May', stock: 1890, usage: 4800 },
  { name: 'Jun', stock: 2390, usage: 3800 },
  { name: 'Jul', stock: 3490, usage: 4300 },
];

const departmentData = [
  { name: 'Emergency', value: 400 },
  { name: 'ICU', value: 300 },
  { name: 'Pharmacy', value: 300 },
  { name: 'Surgery', value: 200 },
];
const COLORS = ['#2563EB', '#14B8A6', '#F59E0B', '#EF4444'];

const Dashboard = () => {
    const [widgets, setWidgets] = useState({
        totalMedicines: 0,
        pendingOrders: 0,
        lowStockItems: 0,
        expiringSoon: 0
    });

    const [showAddStock, setShowAddStock] = useState(false);
    const [showIssueItem, setShowIssueItem] = useState(false);
    const [medicines, setMedicines] = useState([]);
    const [departments, setDepartments] = useState([]);
    const [batches, setBatches] = useState([]);
    const [stockForm, setStockForm] = useState({ medicine_id: '', batch_number: '', mfg_date: '', exp_date: '', quantity: '', unit_price: '' });
    const [issueForm, setIssueForm] = useState({ department_id: '', batch_id: '', quantity: '' });

    const fetchDashboardData = async () => {
        try {
            const res = await api.get('/dashboard/widgets');
            setWidgets(res.data);
        } catch (error) {
            console.error("Error fetching dashboard data", error);
        }
    };

    useEffect(() => {
        fetchDashboardData();
        api.get('/medicines').then(res => setMedicines(res.data)).catch(console.error);
        api.get('/departments').then(res => setDepartments(res.data)).catch(console.error);
        api.get('/batches').then(res => setBatches(res.data.filter(b => b.status === 'Available' && b.quantity > 0))).catch(console.error);
    }, []);

    const handleAddStock = async (e) => {
        e.preventDefault();
        try {
            await api.post('/batches', stockForm);
            alert("Stock added successfully!");
            setShowAddStock(false);
            setStockForm({ medicine_id: '', batch_number: '', mfg_date: '', exp_date: '', quantity: '', unit_price: '' });
            fetchDashboardData();
            api.get('/batches').then(res => setBatches(res.data.filter(b => b.status === 'Available' && b.quantity > 0))).catch(console.error);
        } catch (err) {
            alert("Error adding stock.");
            console.error(err);
        }
    };

    const handleIssueItem = async (e) => {
        e.preventDefault();
        try {
            await api.post('/distributions', issueForm);
            alert("Item issued successfully!");
            setShowIssueItem(false);
            setIssueForm({ department_id: '', batch_id: '', quantity: '' });
            fetchDashboardData();
            api.get('/batches').then(res => setBatches(res.data.filter(b => b.status === 'Available' && b.quantity > 0))).catch(console.error);
        } catch (err) {
            alert(err.response?.data?.error || "Error issuing item. Ensure sufficient batch quantity.");
            console.error(err);
        }
    };

    const statCards = [
        { title: 'Total Medicines', value: widgets.totalMedicines, icon: Package, color: 'text-blue-600', bg: 'bg-blue-50/50', border: 'border-blue-200', trend: '+12%', positive: true },
        { title: 'Pending Orders', value: widgets.pendingOrders, icon: Clock, color: 'text-amber-500', bg: 'bg-amber-50/50', border: 'border-amber-200', trend: '-2%', positive: false },
        { title: 'Low Stock Alerts', value: widgets.lowStockItems, icon: Activity, color: 'text-rose-500', bg: 'bg-rose-50/50', border: 'border-rose-200', trend: '+4%', positive: false },
        { title: 'Expiring Soon', value: widgets.expiringSoon, icon: AlertTriangle, color: 'text-orange-500', bg: 'bg-orange-50/50', border: 'border-orange-200', trend: 'Critical', positive: false }
    ];

    return (
        <div className="space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h2 className="text-3xl font-extrabold text-slate-800 tracking-tight">Executive Dashboard</h2>
                    <p className="text-slate-500 mt-2 font-medium">Real-time overview of hospital inventory and analytics.</p>
                </div>
                <div className="flex gap-4">
                    <button onClick={() => setShowAddStock(true)} className="bg-gradient-premium hover:shadow-lg hover:shadow-blue-500/30 text-white px-5 py-2.5 rounded-xl font-medium transition-all flex items-center gap-2 hover:-translate-y-0.5">
                        <Package size={20} /> Receive Stock
                    </button>
                    <button onClick={() => setShowIssueItem(true)} className="bg-teal-500 hover:bg-teal-600 hover:shadow-lg hover:shadow-teal-500/30 text-white px-5 py-2.5 rounded-xl font-medium transition-all flex items-center gap-2 hover:-translate-y-0.5">
                        <Activity size={20} /> Issue Item
                    </button>
                </div>
            </header>

            {/* KPI Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                {statCards.map((stat, index) => (
                    <div key={index} className="glass-panel p-6 rounded-3xl relative overflow-hidden group hover:-translate-y-1 transition-transform duration-300">
                        <div className="absolute -right-6 -top-6 w-24 h-24 rounded-full opacity-10 bg-current transition-transform group-hover:scale-150" style={{ color: stat.color.replace('text-', '') }}></div>
                        <div className="flex justify-between items-start relative z-10">
                            <div>
                                <p className="text-slate-500 font-bold text-sm tracking-wider uppercase mb-2">{stat.title}</p>
                                <h3 className="text-4xl font-extrabold text-slate-800">{stat.value}</h3>
                            </div>
                            <div className={`${stat.bg} ${stat.color} p-3 rounded-2xl border ${stat.border} shadow-sm`}>
                                <stat.icon size={26} strokeWidth={2.5} />
                            </div>
                        </div>
                        <div className="mt-5 flex items-center text-sm font-semibold">
                            {stat.positive ? (
                                <span className="flex items-center text-emerald-600 bg-emerald-50 px-2 py-1 rounded-lg"><ArrowUpRight size={16} className="mr-1" /> {stat.trend}</span>
                            ) : (
                                <span className="flex items-center text-rose-600 bg-rose-50 px-2 py-1 rounded-lg"><ArrowDownRight size={16} className="mr-1" /> {stat.trend}</span>
                            )}
                            <span className="text-slate-400 ml-3">vs last month</span>
                        </div>
                    </div>
                ))}
            </div>

            {/* Charts Section */}
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div className="lg:col-span-2 glass-panel p-6 rounded-3xl">
                    <div className="flex justify-between items-center mb-6">
                        <h3 className="text-xl font-bold text-slate-800">Inventory Supply vs Usage Trends</h3>
                        <select className="bg-slate-50 border border-slate-200 text-sm font-medium rounded-lg px-3 py-1.5 outline-none text-slate-600">
                            <option>Last 6 Months</option>
                            <option>This Year</option>
                        </select>
                    </div>
                    <div className="h-80 w-full">
                        <ResponsiveContainer width="100%" height="100%">
                            <AreaChart data={inventoryTrendsData} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
                                <defs>
                                    <linearGradient id="colorStock" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="#2563EB" stopOpacity={0.3}/>
                                        <stop offset="95%" stopColor="#2563EB" stopOpacity={0}/>
                                    </linearGradient>
                                    <linearGradient id="colorUsage" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="#14B8A6" stopOpacity={0.3}/>
                                        <stop offset="95%" stopColor="#14B8A6" stopOpacity={0}/>
                                    </linearGradient>
                                </defs>
                                <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{fill: '#94a3b8', fontSize: 12}} dy={10} />
                                <YAxis axisLine={false} tickLine={false} tick={{fill: '#94a3b8', fontSize: 12}} dx={-10} />
                                <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
                                <Tooltip contentStyle={{ borderRadius: '16px', border: 'none', boxShadow: '0 10px 25px rgba(0,0,0,0.1)' }} />
                                <Area type="monotone" dataKey="stock" stroke="#2563EB" strokeWidth={3} fillOpacity={1} fill="url(#colorStock)" />
                                <Area type="monotone" dataKey="usage" stroke="#14B8A6" strokeWidth={3} fillOpacity={1} fill="url(#colorUsage)" />
                            </AreaChart>
                        </ResponsiveContainer>
                    </div>
                </div>

                <div className="glass-panel p-6 rounded-3xl flex flex-col">
                    <h3 className="text-xl font-bold text-slate-800 mb-2">Department Consumption</h3>
                    <p className="text-sm text-slate-500 mb-6">Distribution breakdown by department volume</p>
                    <div className="flex-1 h-64">
                        <ResponsiveContainer width="100%" height="100%">
                            <PieChart>
                                <Pie data={departmentData} cx="50%" cy="50%" innerRadius={60} outerRadius={90} paddingAngle={5} dataKey="value">
                                    {departmentData.map((entry, index) => (
                                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                                    ))}
                                </Pie>
                                <Tooltip contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 4px 15px rgba(0,0,0,0.05)' }} />
                            </PieChart>
                        </ResponsiveContainer>
                    </div>
                    <div className="grid grid-cols-2 gap-3 mt-4">
                        {departmentData.map((dept, index) => (
                            <div key={dept.name} className="flex items-center gap-2">
                                <div className="w-3 h-3 rounded-full" style={{ backgroundColor: COLORS[index % COLORS.length] }}></div>
                                <span className="text-xs font-semibold text-slate-600">{dept.name}</span>
                            </div>
                        ))}
                    </div>
                </div>
            </div>

            {/* Modals */}
            {/* Add Stock Modal */}
            {showAddStock && (
                <div className="fixed inset-0 bg-slate-900/40 backdrop-blur-md z-50 flex items-center justify-center p-4 animate-in fade-in zoom-in-95 duration-200">
                    <div className="bg-white/90 backdrop-blur-xl border border-white rounded-3xl w-full max-w-xl shadow-[0_20px_60px_rgba(0,0,0,0.1)] overflow-hidden">
                        <div className="flex justify-between items-center p-6 border-b border-slate-200/50">
                            <div className="flex items-center gap-3">
                                <div className="bg-blue-100 p-2 rounded-xl text-blue-600"><Package size={20}/></div>
                                <h3 className="text-xl font-bold text-slate-800">Receive Stock Batch</h3>
                            </div>
                            <button onClick={() => setShowAddStock(false)} className="text-slate-400 hover:text-slate-700 bg-slate-100 hover:bg-slate-200 p-2 rounded-full transition-colors"><X size={20}/></button>
                        </div>
                        <form onSubmit={handleAddStock} className="p-6 space-y-5">
                            <div>
                                <label className="block text-sm font-semibold text-slate-700 mb-1.5">Medicine Catalog Item</label>
                                <select required className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                    value={stockForm.medicine_id} onChange={e => setStockForm({...stockForm, medicine_id: e.target.value})}>
                                    <option value="">Select from catalog...</option>
                                    {medicines.map(m => <option key={m.medicine_id} value={m.medicine_id}>{m.medicine_name} ({m.category})</option>)}
                                </select>
                            </div>
                            <div className="grid grid-cols-2 gap-5">
                                <div>
                                    <label className="block text-sm font-semibold text-slate-700 mb-1.5">Batch Number</label>
                                    <input required type="text" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                        value={stockForm.batch_number} onChange={e => setStockForm({...stockForm, batch_number: e.target.value})} placeholder="e.g. BATCH-001" />
                                </div>
                                <div>
                                    <label className="block text-sm font-semibold text-slate-700 mb-1.5">Unit Price (USD)</label>
                                    <input required type="number" step="0.01" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                        value={stockForm.unit_price} onChange={e => setStockForm({...stockForm, unit_price: e.target.value})} placeholder="0.00" />
                                </div>
                            </div>
                            <div className="grid grid-cols-2 gap-5">
                                <div>
                                    <label className="block text-sm font-semibold text-slate-700 mb-1.5">Manufacturing Date</label>
                                    <input required type="date" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                        value={stockForm.mfg_date} onChange={e => setStockForm({...stockForm, mfg_date: e.target.value})} />
                                </div>
                                <div>
                                    <label className="block text-sm font-semibold text-slate-700 mb-1.5">Expiry Date</label>
                                    <input required type="date" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-orange-500/10 focus:border-orange-400 outline-none transition-all text-slate-700 font-medium" 
                                        value={stockForm.exp_date} onChange={e => setStockForm({...stockForm, exp_date: e.target.value})} />
                                </div>
                            </div>
                            <div>
                                <label className="block text-sm font-semibold text-slate-700 mb-1.5">Quantity Received</label>
                                <input required type="number" min="1" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                    value={stockForm.quantity} onChange={e => setStockForm({...stockForm, quantity: e.target.value})} placeholder="Enter total units received" />
                            </div>
                            <div className="pt-6 mt-2 flex justify-end gap-3">
                                <button type="button" onClick={() => setShowAddStock(false)} className="px-6 py-3 rounded-xl font-bold text-slate-600 hover:bg-slate-100 transition-colors">Cancel</button>
                                <button type="submit" className="px-6 py-3 rounded-xl font-bold bg-blue-600 hover:bg-blue-700 text-white shadow-lg shadow-blue-500/30 transition-all hover:-translate-y-0.5">Commit to Inventory</button>
                            </div>
                        </form>
                    </div>
                </div>
            )}

            {/* Issue Item Modal */}
            {showIssueItem && (
                <div className="fixed inset-0 bg-slate-900/40 backdrop-blur-md z-50 flex items-center justify-center p-4 animate-in fade-in zoom-in-95 duration-200">
                    <div className="bg-white/90 backdrop-blur-xl border border-white rounded-3xl w-full max-w-xl shadow-[0_20px_60px_rgba(0,0,0,0.1)] overflow-hidden">
                        <div className="flex justify-between items-center p-6 border-b border-slate-200/50">
                            <div className="flex items-center gap-3">
                                <div className="bg-teal-100 p-2 rounded-xl text-teal-600"><Activity size={20}/></div>
                                <h3 className="text-xl font-bold text-slate-800">Issue Supply to Department</h3>
                            </div>
                            <button onClick={() => setShowIssueItem(false)} className="text-slate-400 hover:text-slate-700 bg-slate-100 hover:bg-slate-200 p-2 rounded-full transition-colors"><X size={20}/></button>
                        </div>
                        <form onSubmit={handleIssueItem} className="p-6 space-y-5">
                            <div>
                                <label className="block text-sm font-semibold text-slate-700 mb-1.5">Requesting Department</label>
                                <select required className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-teal-500/10 focus:border-teal-500 outline-none transition-all text-slate-700 font-medium" 
                                    value={issueForm.department_id} onChange={e => setIssueForm({...issueForm, department_id: e.target.value})}>
                                    <option value="">Select Destination...</option>
                                    {departments.map(d => <option key={d.department_id} value={d.department_id}>{d.department_name}</option>)}
                                </select>
                            </div>
                            <div>
                                <label className="block text-sm font-semibold text-slate-700 mb-1.5">Select Source Batch</label>
                                <select required className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-teal-500/10 focus:border-teal-500 outline-none transition-all text-slate-700 font-medium" 
                                    value={issueForm.batch_id} onChange={e => setIssueForm({...issueForm, batch_id: e.target.value})}>
                                    <option value="">Select active batch...</option>
                                    {batches.map(b => <option key={b.batch_id} value={b.batch_id}>{b.medicine_name} (Batch: {b.batch_number} - Available: {b.quantity})</option>)}
                                </select>
                            </div>
                            <div>
                                <label className="block text-sm font-semibold text-slate-700 mb-1.5">Quantity to Issue</label>
                                <input required type="number" min="1" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-teal-500/10 focus:border-teal-500 outline-none transition-all text-slate-700 font-medium" 
                                    value={issueForm.quantity} onChange={e => setIssueForm({...issueForm, quantity: e.target.value})} placeholder="Units to distribute" />
                            </div>
                            <div className="pt-6 mt-2 flex justify-end gap-3">
                                <button type="button" onClick={() => setShowIssueItem(false)} className="px-6 py-3 rounded-xl font-bold text-slate-600 hover:bg-slate-100 transition-colors">Cancel</button>
                                <button type="submit" className="px-6 py-3 rounded-xl font-bold bg-teal-500 hover:bg-teal-600 text-white shadow-lg shadow-teal-500/30 transition-all hover:-translate-y-0.5">Authorize & Issue</button>
                            </div>
                        </form>
                    </div>
                </div>
            )}
        </div>
    );
};

export default Dashboard;
