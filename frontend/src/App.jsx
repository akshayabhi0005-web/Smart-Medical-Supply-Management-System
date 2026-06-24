import React, { useState } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import TopNav from './components/TopNav';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import Medicines from './pages/Medicines';
import Batches from './pages/Batches';
import Suppliers from './pages/Suppliers';
import Departments from './pages/Departments';
import Purchases from './pages/Purchases';
import Distributions from './pages/Distributions';
import Alerts from './pages/Alerts';
import Reports from './pages/Reports';

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  if (!isAuthenticated) {
    return (
      <Router>
        <Routes>
          <Route path="*" element={<Login onLogin={() => setIsAuthenticated(true)} />} />
        </Routes>
      </Router>
    );
  }

  return (
    <Router>
      <div className="flex h-screen bg-[#F4F7FE] text-slate-800 relative overflow-hidden">
        {/* Giant Single Medical Red Cross Background Watermark */}
        <div 
          className="fixed inset-0 z-0 opacity-[0.03] pointer-events-none bg-no-repeat bg-center" 
          style={{
             backgroundImage: `url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M40 40 V20 h20 v20 h20 v20 h-20 v20 h-20 v-20 h-20 v-20 h20 z M 10 47 L 35 47 L 45 27 L 55 67 L 65 47 L 90 47 L 90 53 L 65 53 L 55 73 L 45 33 L 35 53 L 10 53 Z' fill='%232563EB' fill-rule='evenodd'/%3E%3C/svg%3E")`,
             backgroundSize: '120vh'
          }}
        ></div>

        <Sidebar onLogout={() => setIsAuthenticated(false)} />
        
        <div className="flex-1 flex flex-col h-full relative z-10 overflow-hidden">
            <TopNav />
            <main className="flex-1 p-8 overflow-y-auto custom-scrollbar">
                <div className="max-w-7xl mx-auto">
                    <Routes>
                        <Route path="/" element={<Navigate to="/dashboard" />} />
                        <Route path="/dashboard" element={<Dashboard />} />
                        <Route path="/medicines" element={<Medicines />} />
                        <Route path="/batches" element={<Batches />} />
                        <Route path="/suppliers" element={<Suppliers />} />
                        <Route path="/departments" element={<Departments />} />
                        <Route path="/purchases" element={<Purchases />} />
                        <Route path="/distributions" element={<Distributions />} />
                        <Route path="/alerts" element={<Alerts />} />
                        <Route path="/reports" element={<Reports />} />
                    </Routes>
                </div>
            </main>
        </div>
      </div>
    </Router>
  );
}

export default App;
