import React, { useEffect, useState } from 'react';
import api from '../api';
import { Pill, Search, Plus, X, Package, Eye } from 'lucide-react';

const Medicines = () => {
    const [medicines, setMedicines] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    
    // Modal states
    const [showAddModal, setShowAddModal] = useState(false);
    const [viewMedicine, setViewMedicine] = useState(null); // holds detailed medicine data

    const [addForm, setAddForm] = useState({ name: '', generic_name: '', category: '', uom: '', reorder_level: '' });

    const fetchMedicines = async () => {
        try {
            const res = await api.get('/medicines');
            setMedicines(res.data);
        } catch (error) {
            console.error("Error fetching medicines", error);
        }
    };

    useEffect(() => {
        fetchMedicines();
    }, []);

    const handleAddSubmit = async (e) => {
        e.preventDefault();
        try {
            await api.post('/medicines', addForm);
            alert("Medicine added successfully!");
            setShowAddModal(false);
            setAddForm({ name: '', generic_name: '', category: '', uom: '', reorder_level: '' });
            fetchMedicines();
        } catch (err) {
            console.error(err);
            alert("Error adding medicine.");
        }
    };

    const handleView = async (id) => {
        try {
            const res = await api.get(`/medicines/${id}`);
            setViewMedicine(res.data);
        } catch (err) {
            console.error(err);
            alert("Failed to load medicine details");
        }
    };

    const filteredMeds = medicines.filter(m => 
        m.medicine_name.toLowerCase().includes(searchTerm.toLowerCase()) || 
        m.category.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h2 className="text-3xl font-extrabold text-slate-800 tracking-tight flex items-center gap-3"><Pill className="text-blue-600" size={32} /> Central Drug Catalog</h2>
                    <p className="text-slate-500 mt-2 font-medium">Manage hospital formulary and alert thresholds.</p>
                </div>
                <button onClick={() => setShowAddModal(true)} className="bg-gradient-premium hover:shadow-lg hover:shadow-blue-500/30 text-white px-5 py-2.5 rounded-xl font-medium transition-all flex items-center gap-2 hover:-translate-y-0.5">
                    <Plus size={20} /> Add to Catalog
                </button>
            </header>

            <div className="glass-panel rounded-3xl overflow-hidden">
                <div className="p-6 border-b border-slate-200/60 bg-white/40">
                    <div className="relative max-w-md">
                        <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
                        <input 
                            type="text" 
                            placeholder="Search by brand name or category..."
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
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Medicine Name</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Category</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Total Stock</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider">Status</th>
                                <th className="px-6 py-4 font-bold uppercase tracking-wider text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {filteredMeds.map(med => (
                                <tr key={med.medicine_id} className="hover:bg-slate-50/50 transition-colors group">
                                    <td className="px-6 py-4 text-slate-400 font-medium">M{med.medicine_id.toString().padStart(3, '0')}</td>
                                    <td className="px-6 py-4">
                                        <div className="text-slate-800 font-bold">{med.medicine_name}</div>
                                        <div className="text-xs text-slate-500 font-medium mt-0.5">{med.generic_name}</div>
                                    </td>
                                    <td className="px-6 py-4 text-slate-600 font-medium">{med.category}</td>
                                    <td className="px-6 py-4 font-bold text-slate-700">{med.total_stock || 0} <span className="text-slate-400 font-medium text-xs ml-1">{med.unit_of_measure}</span></td>
                                    <td className="px-6 py-4">
                                        <span className={`px-3 py-1.5 rounded-lg text-xs font-bold ${
                                            med.stock_status === 'Sufficient' ? 'bg-emerald-100 text-emerald-700' : 
                                            med.stock_status === 'Out of Stock' ? 'bg-red-100 text-red-700' : 
                                            'bg-orange-100 text-orange-700'
                                        }`}>
                                            {med.stock_status || 'Unknown'}
                                        </span>
                                    </td>
                                    <td className="px-6 py-4 text-right">
                                        <button onClick={() => handleView(med.medicine_id)} className="text-blue-600 bg-blue-50 hover:bg-blue-600 hover:text-white px-3 py-1.5 rounded-lg text-sm font-semibold transition-colors inline-flex items-center gap-1.5">
                                            <Eye size={16} /> View
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>

            {/* Add Medicine Modal */}
            {showAddModal && (
                <div className="fixed inset-0 bg-slate-900/40 backdrop-blur-md z-50 flex items-center justify-center p-4 animate-in fade-in zoom-in-95 duration-200">
                    <div className="bg-white/90 backdrop-blur-xl border border-white rounded-3xl w-full max-w-xl shadow-[0_20px_60px_rgba(0,0,0,0.1)] overflow-hidden">
                        <div className="flex justify-between items-center p-6 border-b border-slate-200/50">
                            <div className="flex items-center gap-3">
                                <div className="bg-blue-100 p-2 rounded-xl text-blue-600"><Pill size={20}/></div>
                                <h3 className="text-xl font-bold text-slate-800">Add New Medicine</h3>
                            </div>
                            <button onClick={() => setShowAddModal(false)} className="text-slate-400 hover:text-slate-700 bg-slate-100 hover:bg-slate-200 p-2 rounded-full transition-colors"><X size={20}/></button>
                        </div>
                        <form onSubmit={handleAddSubmit} className="p-6 space-y-5">
                            <div>
                                <label className="block text-sm font-semibold text-slate-700 mb-1.5">Brand Name</label>
                                <input required type="text" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                    value={addForm.name} onChange={e => setAddForm({...addForm, name: e.target.value})} placeholder="e.g. Tylenol" />
                            </div>
                            <div>
                                <label className="block text-sm font-semibold text-slate-700 mb-1.5">Generic Name</label>
                                <input required type="text" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                    value={addForm.generic_name} onChange={e => setAddForm({...addForm, generic_name: e.target.value})} placeholder="e.g. Paracetamol" />
                            </div>
                            <div className="grid grid-cols-2 gap-5">
                                <div>
                                    <label className="block text-sm font-semibold text-slate-700 mb-1.5">Category</label>
                                    <input required type="text" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                        value={addForm.category} onChange={e => setAddForm({...addForm, category: e.target.value})} placeholder="e.g. Analgesic" />
                                </div>
                                <div>
                                    <label className="block text-sm font-semibold text-slate-700 mb-1.5">Unit of Measure</label>
                                    <input required type="text" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                        value={addForm.uom} onChange={e => setAddForm({...addForm, uom: e.target.value})} placeholder="e.g. Tablets" />
                                </div>
                            </div>
                            <div>
                                <label className="block text-sm font-semibold text-slate-700 mb-1.5">Reorder Level Threshold</label>
                                <input required type="number" min="0" className="w-full bg-slate-50/50 border border-slate-200 rounded-xl p-3.5 focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 outline-none transition-all text-slate-700 font-medium" 
                                    value={addForm.reorder_level} onChange={e => setAddForm({...addForm, reorder_level: e.target.value})} placeholder="e.g. 500" />
                            </div>
                            <div className="pt-6 mt-2 flex justify-end gap-3">
                                <button type="button" onClick={() => setShowAddModal(false)} className="px-6 py-3 rounded-xl font-bold text-slate-600 hover:bg-slate-100 transition-colors">Cancel</button>
                                <button type="submit" className="px-6 py-3 rounded-xl font-bold bg-blue-600 hover:bg-blue-700 text-white shadow-lg shadow-blue-500/30 transition-all hover:-translate-y-0.5">Add to Catalog</button>
                            </div>
                        </form>
                    </div>
                </div>
            )}

            {/* View Medicine Modal */}
            {viewMedicine && (
                <div className="fixed inset-0 bg-slate-900/40 backdrop-blur-md z-50 flex items-center justify-center p-4 animate-in fade-in zoom-in-95 duration-200">
                    <div className="bg-white/90 backdrop-blur-xl border border-white rounded-3xl w-full max-w-2xl shadow-[0_20px_60px_rgba(0,0,0,0.1)] overflow-hidden">
                        <div className="flex justify-between items-center p-6 border-b border-slate-200/50">
                            <div className="flex items-center gap-3">
                                <div className="bg-blue-100 p-2 rounded-xl text-blue-600"><Pill size={20}/></div>
                                <h3 className="text-xl font-bold text-slate-800">Formulary Details</h3>
                            </div>
                            <button onClick={() => setViewMedicine(null)} className="text-slate-400 hover:text-slate-700 bg-slate-100 hover:bg-slate-200 p-2 rounded-full transition-colors"><X size={20}/></button>
                        </div>
                        <div className="p-8">
                            <div className="grid grid-cols-2 gap-8 mb-8">
                                <div>
                                    <p className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-1">Brand Name</p>
                                    <p className="font-extrabold text-slate-800 text-xl">{viewMedicine.medicine_name}</p>
                                </div>
                                <div>
                                    <p className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-1">Generic Name</p>
                                    <p className="font-extrabold text-slate-800 text-xl">{viewMedicine.generic_name}</p>
                                </div>
                                <div>
                                    <p className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-1">Category</p>
                                    <p className="font-semibold text-slate-700 text-lg">{viewMedicine.category}</p>
                                </div>
                                <div>
                                    <p className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-1">Unit of Measure</p>
                                    <p className="font-semibold text-slate-700 text-lg">{viewMedicine.unit_of_measure}</p>
                                </div>
                                <div className="col-span-2 bg-gradient-premium p-6 rounded-2xl flex justify-between items-center shadow-lg shadow-blue-500/20 text-white">
                                    <div>
                                        <p className="text-sm text-blue-100 font-medium mb-1">Total Stock Available</p>
                                        <p className="font-extrabold text-4xl">{viewMedicine.total_stock || 0}</p>
                                    </div>
                                    <div className="text-right">
                                        <p className="text-sm text-blue-100 font-medium mb-1">Reorder Alert Threshold</p>
                                        <p className="font-bold text-2xl">{viewMedicine.reorder_level}</p>
                                    </div>
                                </div>
                            </div>
                            
                            <h4 className="font-bold text-slate-800 mb-4 flex items-center gap-2"><Package size={18} className="text-blue-500"/> Active Inventory Batches</h4>
                            {viewMedicine.batches && viewMedicine.batches.length > 0 ? (
                                <div className="border border-slate-200/60 rounded-2xl overflow-hidden max-h-48 overflow-y-auto custom-scrollbar">
                                    <table className="w-full text-left text-sm">
                                        <thead className="bg-slate-50 sticky top-0 border-b border-slate-200/60">
                                            <tr>
                                                <th className="p-4 font-bold text-slate-500">Batch No</th>
                                                <th className="p-4 font-bold text-slate-500">Quantity</th>
                                                <th className="p-4 font-bold text-slate-500">Expiry</th>
                                                <th className="p-4 font-bold text-slate-500">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody className="divide-y divide-slate-100 bg-white">
                                            {viewMedicine.batches.map((b, i) => (
                                                <tr key={i} className="hover:bg-slate-50/50">
                                                    <td className="p-4 font-semibold text-slate-700">{b.batch_number}</td>
                                                    <td className="p-4 font-extrabold text-slate-800">{b.quantity}</td>
                                                    <td className="p-4 font-medium text-slate-600">{new Date(b.expiry_date).toLocaleDateString()}</td>
                                                    <td className="p-4">
                                                        <span className={`px-2.5 py-1 rounded-md text-xs font-bold ${
                                                            b.status === 'Available' ? 'bg-emerald-100 text-emerald-700' : 'bg-red-100 text-red-700'
                                                        }`}>{b.status}</span>
                                                    </td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                </div>
                            ) : (
                                <div className="bg-slate-50 p-6 rounded-2xl text-center border border-slate-100">
                                    <p className="text-slate-500 font-medium">No active batches for this medicine.</p>
                                </div>
                            )}
                        </div>
                        <div className="p-6 border-t border-slate-200/50 flex justify-end">
                            <button onClick={() => setViewMedicine(null)} className="px-8 py-3 rounded-xl font-bold bg-slate-100 hover:bg-slate-200 text-slate-700 transition-colors">Close Details</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default Medicines;
