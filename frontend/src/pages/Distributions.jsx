import React, { useEffect, useState } from 'react';
import api from '../api';
import { Activity, Send } from 'lucide-react';

const Distributions = () => {
    const [distributions, setDistributions] = useState([]);

    useEffect(() => {
        const fetchDistributions = async () => {
            try {
                const res = await api.get('/distributions');
                setDistributions(res.data);
            } catch (error) {
                console.error("Error fetching distributions", error);
            }
        };
        fetchDistributions();
    }, []);

    return (
        <div className="space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h2 className="text-3xl font-extrabold text-slate-800 tracking-tight flex items-center gap-3"><Activity className="text-blue-600" size={32} /> Department Distributions</h2>
                    <p className="text-slate-500 mt-2 font-medium">Log of all internal supply transfers and consumption.</p>
                </div>
                <button className="bg-gradient-premium hover:shadow-lg hover:shadow-blue-500/30 text-white px-5 py-2.5 rounded-xl font-medium transition-all flex items-center gap-2 hover:-translate-y-0.5">
                    <Send size={20} /> Issue Supplies
                </button>
            </header>

            <div className="glass-panel rounded-3xl overflow-hidden">
                <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse">
                        <thead>
                            <tr className="bg-slate-50/50 text-slate-500 border-b border-slate-200/60 text-sm">
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Date</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Destination Department</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Medicine (Batch)</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Quantity Issued</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Requested By</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {distributions.map(d => (
                                <tr key={d.distribution_id} className="hover:bg-slate-50/50 transition-colors group">
                                    <td className="px-6 py-4 text-slate-600 font-medium">{new Date(d.issue_date).toLocaleDateString()}</td>
                                    <td className="px-6 py-4 text-slate-800 font-bold">{d.department_name}</td>
                                    <td className="px-6 py-4 text-slate-600 font-semibold">{d.medicine_name} <span className="text-slate-400 font-normal text-xs ml-1">({d.batch_number})</span></td>
                                    <td className="px-6 py-4 text-teal-600 font-extrabold">{d.quantity_issued}</td>
                                    <td className="px-6 py-4 text-slate-500 font-medium">{d.requested_by_name}</td>
                                </tr>
                            ))}
                            {distributions.length === 0 && (
                                <tr>
                                    <td colSpan="5" className="px-6 py-8 text-center text-slate-500 font-medium">No distribution records found.</td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default Distributions;
