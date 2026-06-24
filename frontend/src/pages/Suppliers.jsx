import React, { useEffect, useState } from 'react';
import api from '../api';
import { Truck, Search, Plus, ExternalLink } from 'lucide-react';

const Suppliers = () => {
    const [suppliers, setSuppliers] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');

    useEffect(() => {
        const fetchSuppliers = async () => {
            try {
                const res = await api.get('/suppliers');
                setSuppliers(res.data);
            } catch (error) {
                console.error("Error fetching suppliers", error);
            }
        };
        fetchSuppliers();
    }, []);

    const filtered = suppliers.filter(s => 
        s.supplier_name.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h2 className="text-3xl font-extrabold text-slate-800 tracking-tight flex items-center gap-3"><Truck className="text-blue-600" size={32} /> Approved Suppliers</h2>
                    <p className="text-slate-500 mt-2 font-medium">Manage hospital vendors and supply chain partners.</p>
                </div>
                <button className="bg-gradient-premium hover:shadow-lg hover:shadow-blue-500/30 text-white px-5 py-2.5 rounded-xl font-medium transition-all flex items-center gap-2 hover:-translate-y-0.5">
                    <Plus size={20} /> Register Supplier
                </button>
            </header>

            <div className="glass-panel rounded-3xl overflow-hidden">
                <div className="p-6 border-b border-slate-200/60 bg-white/40">
                    <div className="relative max-w-md">
                        <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
                        <input 
                            type="text" 
                            placeholder="Search suppliers by name..."
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
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">ID</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Supplier Name</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Contact Person</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Phone Number</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Total Orders</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Total Spent</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {filtered.map(supplier => (
                                <tr key={supplier.supplier_id} className="hover:bg-slate-50/50 transition-colors group">
                                    <td className="px-6 py-4 text-slate-400 font-medium">S{supplier.supplier_id.toString().padStart(3, '0')}</td>
                                    <td className="px-6 py-4 text-slate-800 font-bold">{supplier.supplier_name}</td>
                                    <td className="px-6 py-4 text-slate-600 font-medium">{supplier.contact_person}</td>
                                    <td className="px-6 py-4 text-slate-600 font-medium">{supplier.phone_number}</td>
                                    <td className="px-6 py-4">
                                        <span className="bg-blue-50 text-blue-700 px-3 py-1 rounded-lg font-bold">{supplier.total_orders_placed}</span>
                                    </td>
                                    <td className="px-6 py-4 text-emerald-600 font-extrabold">${supplier.total_money_spent}</td>
                                    <td className="px-6 py-4 text-right">
                                        <button className="text-slate-400 hover:text-blue-600 transition-colors p-2 hover:bg-blue-50 rounded-lg">
                                            <ExternalLink size={18} />
                                        </button>
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

export default Suppliers;
