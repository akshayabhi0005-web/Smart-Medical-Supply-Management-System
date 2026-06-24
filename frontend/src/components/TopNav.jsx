import React from 'react';
import { Search, Bell, Settings, User } from 'lucide-react';

const TopNav = () => {
    return (
        <header className="h-20 bg-white/70 backdrop-blur-xl border-b border-slate-200/60 flex items-center justify-between px-8 sticky top-0 z-30 shadow-[0_4px_24px_rgba(37,99,235,0.02)]">
            <div className="relative w-96">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
                <input 
                    type="text" 
                    placeholder="Search inventory, batches, or suppliers..."
                    className="w-full bg-slate-50/50 border border-slate-200 rounded-full pl-12 pr-4 py-2.5 text-sm text-slate-800 focus:outline-none focus:bg-white focus:ring-2 focus:ring-blue-100 focus:border-blue-300 transition-all font-medium"
                />
            </div>
            
            <div className="flex items-center gap-5">
                <button className="relative p-2.5 text-slate-500 hover:text-blue-600 hover:bg-blue-50 rounded-full transition-colors">
                    <Bell size={22} />
                    <span className="absolute top-2 right-2 w-2.5 h-2.5 bg-red-500 border-2 border-white rounded-full"></span>
                </button>
                <button className="p-2.5 text-slate-500 hover:text-blue-600 hover:bg-blue-50 rounded-full transition-colors">
                    <Settings size={22} />
                </button>
                <div className="h-8 w-px bg-slate-200 mx-2"></div>
                <div className="flex items-center gap-3 cursor-pointer group">
                    <div className="text-right hidden md:block">
                        <p className="text-sm font-bold text-slate-800 group-hover:text-blue-600 transition-colors">Admin User</p>
                        <p className="text-xs font-medium text-slate-500">System Administrator</p>
                    </div>
                    <div className="w-10 h-10 rounded-full bg-gradient-premium flex items-center justify-center text-white shadow-md shadow-blue-500/20">
                        <User size={20} />
                    </div>
                </div>
            </div>
        </header>
    );
};

export default TopNav;
