import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Activity, Lock, User, ArrowRight, ShieldCheck, HeartPulse } from 'lucide-react';

const Login = ({ onLogin }) => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const navigate = useNavigate();

    const handleLogin = (e) => {
        e.preventDefault();
        if (username === 'admin' && password === 'admin') {
            onLogin();
            navigate('/dashboard');
        } else {
            setError('Invalid credentials. Access denied.');
        }
    };

    return (
        <div className="min-h-screen bg-[#F4F7FE] flex items-center justify-center p-4 relative overflow-hidden">
            {/* Ambient Background Elements */}
            <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-blue-400/20 rounded-full blur-3xl pointer-events-none"></div>
            <div className="absolute bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-teal-400/20 rounded-full blur-3xl pointer-events-none"></div>
            
            {/* The Custom Heartbeat Medical Cross Background */}
            <div 
                className="absolute inset-0 z-0 opacity-[0.03] pointer-events-none bg-no-repeat bg-center" 
                style={{
                   backgroundImage: `url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M40 40 V20 h20 v20 h20 v20 h-20 v20 h-20 v-20 h-20 v-20 h20 z M 10 47 L 35 47 L 45 27 L 55 67 L 65 47 L 90 47 L 90 53 L 65 53 L 55 73 L 45 33 L 35 53 L 10 53 Z' fill='%232563EB' fill-rule='evenodd'/%3E%3C/svg%3E")`,
                   backgroundSize: '120vh'
                }}
            ></div>

            <div className="max-w-5xl w-full flex rounded-3xl shadow-2xl relative z-10 overflow-hidden bg-white/80 backdrop-blur-xl border border-white/50">
                
                {/* Left Side: Branding / Info */}
                <div className="hidden md:flex md:w-1/2 bg-gradient-premium p-12 flex-col justify-between relative overflow-hidden text-white">
                    <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10"></div>
                    <div className="relative z-10">
                        <div className="flex items-center gap-3 mb-8">
                            <div className="bg-white/20 p-3 rounded-2xl backdrop-blur-md">
                                <HeartPulse size={36} className="text-white" />
                            </div>
                            <h1 className="text-3xl font-bold tracking-tight">SMSMS</h1>
                        </div>
                        <h2 className="text-4xl font-extrabold mb-4 leading-tight">Smart Medical Supply Management</h2>
                        <p className="text-blue-100 text-lg leading-relaxed">
                            Enterprise-grade inventory control, automated distribution tracking, and predictive low-stock analytics designed for modern healthcare facilities.
                        </p>
                    </div>
                    
                    <div className="relative z-10 space-y-4">
                        <div className="flex items-center gap-4 bg-white/10 p-4 rounded-2xl backdrop-blur-sm border border-white/10">
                            <ShieldCheck className="text-teal-300" size={28} />
                            <div>
                                <p className="font-semibold">Secure HIPAA Compliant</p>
                                <p className="text-sm text-blue-200">End-to-end encrypted data transmission</p>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Right Side: Login Form */}
                <div className="w-full md:w-1/2 p-8 md:p-12 lg:p-16 flex flex-col justify-center bg-white/60">
                    <div className="mb-10 text-center md:text-left">
                        <h3 className="text-3xl font-bold text-slate-800 mb-2">Welcome Back</h3>
                        <p className="text-slate-500 font-medium">Please enter your credentials to access the portal.</p>
                    </div>

                    <form onSubmit={handleLogin} className="space-y-6">
                        {error && (
                            <div className="bg-red-50 border border-red-200 text-red-600 p-4 rounded-xl text-sm flex items-center gap-3">
                                <Activity size={18} className="shrink-0" /> {error}
                            </div>
                        )}
                        
                        <div className="space-y-2">
                            <label className="text-sm font-semibold text-slate-700 ml-1">Admin ID</label>
                            <div className="relative">
                                <User className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
                                <input 
                                    type="text" 
                                    className="w-full bg-white/50 border border-slate-200 rounded-2xl pl-12 pr-4 py-3.5 text-slate-800 focus:outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 transition-all font-medium"
                                    placeholder="Enter username (admin)"
                                    value={username}
                                    onChange={(e) => setUsername(e.target.value)}
                                    required
                                />
                            </div>
                        </div>

                        <div className="space-y-2">
                            <label className="text-sm font-semibold text-slate-700 ml-1">Security Key</label>
                            <div className="relative">
                                <Lock className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
                                <input 
                                    type="password" 
                                    className="w-full bg-white/50 border border-slate-200 rounded-2xl pl-12 pr-4 py-3.5 text-slate-800 focus:outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 transition-all font-medium"
                                    placeholder="Enter password (admin)"
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                    required
                                />
                            </div>
                        </div>

                        <div className="pt-2">
                            <button 
                                type="submit" 
                                className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-4 rounded-2xl transition-all flex items-center justify-center gap-2 shadow-[0_8px_20px_rgba(37,99,235,0.2)] hover:shadow-[0_10px_25px_rgba(37,99,235,0.3)] hover:-translate-y-0.5 group"
                            >
                                Secure Login <ArrowRight size={20} className="group-hover:translate-x-1.5 transition-transform" />
                            </button>
                        </div>
                    </form>
                    
                    <div className="mt-10 text-center">
                        <p className="text-slate-400 text-sm font-medium">
                            Authorized personnel only. <span className="text-blue-500 hover:underline cursor-pointer">Help & Support</span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Login;
