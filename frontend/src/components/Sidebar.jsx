import React from 'react';
import { NavLink } from 'react-router-dom';
import { LayoutDashboard, Pill, Package, Truck, ShoppingCart, Users, Activity, Bell, FileText, LogOut, HeartPulse } from 'lucide-react';

const Sidebar = ({ onLogout }) => {
    const navItems = [
        { name: 'Dashboard', path: '/dashboard', icon: LayoutDashboard },
        { name: 'Medicines', path: '/medicines', icon: Pill },
        { name: 'Batches', path: '/batches', icon: Package },
        { name: 'Suppliers', path: '/suppliers', icon: Truck },
        { name: 'Purchases', path: '/purchases', icon: ShoppingCart },
        { name: 'Departments', path: '/departments', icon: Users },
        { name: 'Distributions', path: '/distributions', icon: Activity },
        { name: 'Alerts', path: '/alerts', icon: Bell },
        { name: 'Reports', path: '/reports', icon: FileText }
    ];

    return (
        <aside className="w-72 bg-white/80 backdrop-blur-xl border-r border-slate-200/60 flex flex-col h-full shadow-[4px_0_24px_rgba(37,99,235,0.03)] z-40 relative">
            <div className="p-6 flex items-center gap-3">
                <div className="bg-gradient-premium p-2.5 rounded-xl text-white shadow-lg shadow-blue-500/30">
                    <HeartPulse size={24} />
                </div>
                <div>
                    <h1 className="text-xl font-extrabold tracking-tight text-slate-800 leading-none">SMSMS</h1>
                    <p className="text-[10px] uppercase font-bold text-teal-600 tracking-wider mt-1">Hospital Core</p>
                </div>
            </div>

            <div className="px-6 pb-2">
                <p className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-2">Main Menu</p>
            </div>

            <ul className="flex-1 overflow-y-auto px-4 space-y-1 custom-scrollbar">
                {navItems.map((item) => (
                    <li key={item.name}>
                        <NavLink
                            to={item.path}
                            className={({ isActive }) =>
                                `flex items-center gap-3 px-4 py-3 rounded-xl transition-all duration-200 ${
                                    isActive
                                        ? 'bg-blue-50 text-blue-700 font-semibold shadow-sm border border-blue-100/50'
                                        : 'text-slate-500 hover:bg-slate-50 hover:text-slate-800 font-medium'
                                }`
                            }
                        >
                            {({ isActive }) => (
                                <>
                                    <item.icon size={20} className={isActive ? 'text-blue-600' : 'text-slate-400'} />
                                    <span>{item.name}</span>
                                </>
                            )}
                        </NavLink>
                    </li>
                ))}
            </ul>

            <div className="p-6 mt-auto">
                <div className="bg-slate-50 rounded-2xl p-4 border border-slate-100 mb-4">
                    <div className="flex items-center gap-3 mb-2">
                        <div className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></div>
                        <span className="text-xs font-bold text-slate-700">System Status</span>
                    </div>
                    <p className="text-xs text-slate-500 leading-relaxed">All backend database services are operating normally.</p>
                </div>
                <button 
                    onClick={onLogout}
                    className="flex items-center justify-center gap-2 w-full p-3 text-slate-600 hover:text-red-600 hover:bg-red-50 rounded-xl transition-all font-semibold border border-slate-200 hover:border-red-100"
                >
                    <LogOut size={18} />
                    <span>Secure Logout</span>
                </button>
            </div>
        </aside>
    );
};

export default Sidebar;
