import React, { useEffect, useState } from 'react';
import api from '../api';
import { FileText, Download } from 'lucide-react';

const Reports = () => {
    const [reports, setReports] = useState([]);

    useEffect(() => {
        const fetchReports = async () => {
            try {
                const res = await api.get('/reports/department-usage');
                setReports(res.data);
            } catch (error) {
                console.error("Error fetching reports", error);
            }
        };
        fetchReports();
    }, []);

    return (
        <div className="space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h2 className="text-3xl font-extrabold text-slate-800 tracking-tight flex items-center gap-3"><FileText className="text-blue-600" size={32} /> Department Usage Analytics</h2>
                    <p className="text-slate-500 mt-2 font-medium">Detailed breakdown of consumption and associated financial costs.</p>
                </div>
                <button className="bg-gradient-premium hover:shadow-lg hover:shadow-blue-500/30 text-white px-5 py-2.5 rounded-xl font-medium transition-all flex items-center gap-2 hover:-translate-y-0.5">
                    <Download size={20} /> Export Report PDF
                </button>
            </header>

            <div className="glass-panel rounded-3xl overflow-hidden">
                <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse">
                        <thead>
                            <tr className="bg-slate-50/50 text-slate-500 border-b border-slate-200/60 text-sm">
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Department</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Medicine Consumed</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Category</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Total Quantity</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider text-right">Financial Cost</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {reports.map((r, i) => (
                                <tr key={i} className="hover:bg-slate-50/50 transition-colors group">
                                    <td className="px-6 py-4 text-slate-800 font-bold">{r.department_name}</td>
                                    <td className="px-6 py-4 text-slate-600 font-semibold">{r.medicine_name}</td>
                                    <td className="px-6 py-4 text-slate-500 font-medium">{r.category}</td>
                                    <td className="px-6 py-4 text-emerald-600 font-extrabold">{r.total_quantity_consumed}</td>
                                    <td className="px-6 py-4 text-blue-700 font-extrabold text-right">${Number(r.total_cost_incurred).toFixed(2)}</td>
                                </tr>
                            ))}
                            {reports.length === 0 && (
                                <tr>
                                    <td colSpan="5" className="px-6 py-8 text-center text-slate-500 font-medium">No usage data found for this period.</td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default Reports;
