import React, { useEffect, useState } from 'react';
import api from '../api';
import { ShoppingCart, Plus } from 'lucide-react';

const Purchases = () => {
    const [purchases, setPurchases] = useState([]);

    useEffect(() => {
        const fetchPurchases = async () => {
            try {
                const res = await api.get('/purchases');
                setPurchases(res.data);
            } catch (error) {
                console.error("Error fetching purchases", error);
            }
        };
        fetchPurchases();
    }, []);

    return (
        <div className="space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h2 className="text-3xl font-extrabold text-slate-800 tracking-tight flex items-center gap-3"><ShoppingCart className="text-blue-600" size={32} /> Purchase Orders</h2>
                    <p className="text-slate-500 mt-2 font-medium">Review and manage supplier purchase requisitions.</p>
                </div>
                <button className="bg-gradient-premium hover:shadow-lg hover:shadow-blue-500/30 text-white px-5 py-2.5 rounded-xl font-medium transition-all flex items-center gap-2 hover:-translate-y-0.5">
                    <Plus size={20} /> New Purchase Order
                </button>
            </header>

            <div className="glass-panel rounded-3xl overflow-hidden">
                <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse">
                        <thead>
                            <tr className="bg-slate-50/50 text-slate-500 border-b border-slate-200/60 text-sm">
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">PO #</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Date</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Supplier</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Ordered By</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Amount</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Status</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {purchases.map(p => (
                                <tr key={p.purchase_id} className="hover:bg-slate-50/50 transition-colors group">
                                    <td className="px-6 py-4 text-slate-800 font-bold">PO-{p.purchase_id.toString().padStart(4, '0')}</td>
                                    <td className="px-6 py-4 text-slate-600 font-medium">{new Date(p.order_date).toLocaleDateString()}</td>
                                    <td className="px-6 py-4 text-slate-800 font-semibold">{p.supplier_name}</td>
                                    <td className="px-6 py-4 text-slate-500">{p.ordered_by_name}</td>
                                    <td className="px-6 py-4 text-blue-700 font-extrabold">${p.total_amount}</td>
                                    <td className="px-6 py-4">
                                        <span className={`px-3 py-1.5 rounded-lg text-xs font-bold ${
                                            p.status === 'Completed' ? 'bg-emerald-100 text-emerald-700' : 
                                            p.status === 'Pending' ? 'bg-amber-100 text-amber-700' : 
                                            'bg-slate-100 text-slate-700'
                                        }`}>
                                            {p.status}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                            {purchases.length === 0 && (
                                <tr>
                                    <td colSpan="6" className="px-6 py-8 text-center text-slate-500 font-medium">No purchase orders found.</td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default Purchases;
