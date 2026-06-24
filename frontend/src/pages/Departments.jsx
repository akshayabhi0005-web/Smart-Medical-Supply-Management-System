import React, { useEffect, useState } from 'react';
import api from '../api';
import { Users } from 'lucide-react';

const Departments = () => {
    const [departments, setDepartments] = useState([]);

    useEffect(() => {
        const fetchDepartments = async () => {
            try {
                const res = await api.get('/departments');
                setDepartments(res.data);
            } catch (error) {
                console.error("Error fetching departments", error);
            }
        };
        fetchDepartments();
    }, []);

    return (
        <div className="space-y-6">
            <header className="flex justify-between items-center">
                <h2 className="text-3xl font-bold text-slate-800 flex items-center gap-3"><Users className="text-blue-600" /> Departments</h2>
            </header>

            <div className="bg-white border border-slate-200 rounded-2xl overflow-hidden shadow-sm">
                <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse">
                        <thead>
                            <tr className="bg-slate-50 text-slate-600 border-b border-slate-200">
                                <th className="p-4 font-medium">Department ID</th>
                                <th className="p-4 font-medium">Department Name</th>
                                <th className="p-4 font-medium">Location</th>
                                <th className="p-4 font-medium">Contact Number</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {departments.map(dept => (
                                <tr key={dept.department_id} className="hover:bg-slate-50 transition-colors">
                                    <td className="p-4 text-slate-500">D{dept.department_id.toString().padStart(3, '0')}</td>
                                    <td className="p-4 text-slate-800 font-medium">{dept.department_name}</td>
                                    <td className="p-4 text-slate-600">{dept.location}</td>
                                    <td className="p-4 text-slate-600">{dept.contact_number}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default Departments;
