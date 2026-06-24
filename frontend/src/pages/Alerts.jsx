import React, { useEffect, useState } from 'react';
import api from '../api';
import { Bell, AlertTriangle, ShieldAlert, Zap, Filter } from 'lucide-react';

const Alerts = () => {
    const [alerts, setAlerts] = useState([]);

    useEffect(() => {
        const fetchAlerts = async () => {
            try {
                const res = await api.get('/alerts');
                setAlerts(res.data);
            } catch (error) {
                console.error("Error fetching alerts", error);
            }
        };
        fetchAlerts();
    }, []);

    return (
        <div className="space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h2 className="text-3xl font-extrabold text-slate-800 tracking-tight flex items-center gap-3">
                        <div className="relative">
                            <Bell className="text-blue-600" size={32} />
                            {alerts.length > 0 && <span className="absolute top-0 right-0 w-3 h-3 bg-rose-500 rounded-full border-2 border-slate-50 animate-pulse"></span>}
                        </div>
                        System Alerts
                    </h2>
                    <p className="text-slate-500 mt-2 font-medium">Monitor critical inventory levels and impending expirations.</p>
                </div>
                <button className="bg-white hover:bg-slate-50 text-slate-700 px-5 py-2.5 rounded-xl font-medium transition-all flex items-center gap-2 shadow-sm border border-slate-200">
                    <Filter size={20} className="text-slate-400" /> Filter Alerts
                </button>
            </header>

            <div className="grid gap-6">
                {alerts.length === 0 ? (
                    <div className="glass-panel p-12 rounded-3xl text-center flex flex-col items-center justify-center">
                        <div className="w-20 h-20 bg-emerald-50 rounded-full flex items-center justify-center mb-4">
                            <Zap className="text-emerald-500" size={40} />
                        </div>
                        <h3 className="text-2xl font-bold text-slate-800 mb-2">All Clear!</h3>
                        <p className="text-slate-500 font-medium">No active alerts in the system. Inventory is healthy.</p>
                    </div>
                ) : (
                    alerts.map(alert => (
                        <div key={alert.alert_id} className={`p-6 rounded-3xl flex items-start gap-5 border shadow-lg transition-transform hover:-translate-y-1 ${
                            alert.alert_type.includes('Expir') 
                                ? 'bg-gradient-to-br from-rose-50 to-white border-rose-200 shadow-rose-500/10' 
                                : 'bg-gradient-to-br from-amber-50 to-white border-amber-200 shadow-amber-500/10'
                        }`}>
                            <div className={`mt-1 p-3 rounded-2xl ${
                                alert.alert_type.includes('Expir') ? 'bg-rose-100 text-rose-600' : 'bg-amber-100 text-amber-600'
                            }`}>
                                {alert.alert_type.includes('Expir') ? <ShieldAlert size={28} /> : <AlertTriangle size={28} />}
                            </div>
                            <div className="flex-1">
                                <h4 className={`font-extrabold text-xl ${alert.alert_type.includes('Expir') ? 'text-rose-900' : 'text-amber-900'}`}>{alert.alert_type}</h4>
                                <p className="text-slate-600 mt-2 text-lg font-medium">
                                    <strong className="text-slate-800">{alert.medicine_name}</strong> {alert.batch_number ? <span className="text-slate-500">({alert.batch_number})</span> : ''} requires immediate attention.
                                </p>
                                <div className="flex items-center gap-4 mt-4">
                                    <span className="text-slate-400 text-sm font-semibold flex items-center gap-1.5">
                                        <Bell size={14} /> Generated: {new Date(alert.alert_date).toLocaleString()}
                                    </span>
                                </div>
                            </div>
                            <div>
                                <span className={`px-4 py-1.5 rounded-xl text-xs font-bold shadow-sm ${
                                    alert.status === 'Resolved' ? 'bg-emerald-100 text-emerald-700' : 'bg-white text-slate-700 border border-slate-200'
                                }`}>
                                    {alert.status}
                                </span>
                            </div>
                        </div>
                    ))
                )}
            </div>
        </div>
    );
};

export default Alerts;
