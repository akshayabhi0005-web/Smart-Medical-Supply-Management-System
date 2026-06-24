import React, { useEffect, useState } from 'react';
import api from '../api';
import { Package, Search, Filter } from 'lucide-react';

const Batches = () => {
    const [batches, setBatches] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');

    useEffect(() => {
        const fetchBatches = async () => {
            try {
                const res = await api.get('/batches');
                setBatches(res.data);
            } catch (error) {
                console.error("Error fetching batches", error);
            }
        };
        fetchBatches();
    }, []);

    const filtered = batches.filter(b => 
        b.medicine_name.toLowerCase().includes(searchTerm.toLowerCase()) || 
        b.batch_number.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h2 className="text-3xl font-extrabold text-slate-800 tracking-tight flex items-center gap-3"><Package className="text-blue-600" size={32} /> Inventory Batches</h2>
                    <p className="text-slate-500 mt-2 font-medium">Detailed tracking of all physical supply units.</p>
                </div>
                <button className="bg-white hover:bg-slate-50 text-slate-700 px-5 py-2.5 rounded-xl font-medium transition-all flex items-center gap-2 shadow-sm border border-slate-200">
                    <Filter size={20} className="text-slate-400" /> Filter Batches
                </button>
            </header>

            <div className="glass-panel rounded-3xl overflow-hidden">
                <div className="p-6 border-b border-slate-200/60 bg-white/40">
                    <div className="relative max-w-md">
                        <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
                        <input 
                            type="text" 
                            placeholder="Search by medicine or batch number..."
                            className="w-full bg-white/60 border border-slate-200 rounded-2xl pl-12 pr-4 py-3 text-sm text-slate-800 focus:outline-none focus:bg-white focus:ring-4 focus:ring-blue-500/10 focus:border-blue-400 transition-all font-medium"
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    </div>
                </div>
                
                <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse">
                        <thead>
                            <tr className="bg-slate-50/50 text-slate-500 border-b border-slate-200/60 text-sm">
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Batch No</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Medicine</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Category</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Quantity</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Expiry Date</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Status</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {filtered.map(batch => (
                                <tr key={batch.batch_id} className="hover:bg-slate-50/50 transition-colors group">
                                    <td className="px-6 py-4 text-slate-800 font-bold">{batch.batch_number}</td>
                                    <td className="px-6 py-4 text-slate-700 font-semibold">{batch.medicine_name}</td>
                                    <td className="px-6 py-4 text-slate-500 font-medium">{batch.category}</td>
                                    <td className="px-6 py-4 text-blue-700 font-extrabold">{batch.quantity}</td>
                                    <td className="px-6 py-4 text-slate-600 font-medium">{new Date(batch.expiry_date).toLocaleDateString()}</td>
                                    <td className="px-6 py-4">
                                        <span className={`px-3 py-1.5 rounded-lg text-xs font-bold ${
                                            batch.status === 'Available' ? 'bg-emerald-100 text-emerald-700' : 
                                            batch.status === 'Quarantine' ? 'bg-amber-100 text-amber-700' : 
                                            'bg-red-100 text-red-700'
                                        }`}>
                                            {batch.status}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default Batches;
