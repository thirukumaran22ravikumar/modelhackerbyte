import { Link } from 'react-router-dom';
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const StudentHeader = () => {
  const [role, setRole] = useState(null);
  const navigate = useNavigate();

  const handleLogout = async () => {
    const email = localStorage.getItem('email');
    console.log(email, "----------------email")
    try {
      const response = await fetch('http://localhost:3001/users/sign_out', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email }),
      });

      const result = await response.json();
      console.log(result);
      if (response.ok) {
        localStorage.removeItem('role');
        localStorage.removeItem('email');
        setRole(null);
        window.location.reload();
        navigate('/user');
      } else {
        localStorage.removeItem('role');
        localStorage.removeItem('email');
        setRole(null);
        window.location.reload();
        navigate('/user');
      }
    } catch (error) {
      console.error('Fetch error:', error);
    }
  };

  return (
    <div className="bg-black p-4 rounded-lg shadow-md">
      <nav className="flex justify-between items-center h-16 bg-gray-800 p-4">
        <button className="block lg:hidden text-white bg-blue-500 px-4 py-2 rounded-md">Menu</button>
        <ul className="hidden lg:flex space-x-6">
          <li>
            <Link to="/student/dashboard" className="text-white font-bold hover:text-gray-400">
              Dashboard
            </Link>
          </li>
          <li>
            <Link to="/student/course" className="text-white font-bold hover:text-gray-400">
              Course
            </Link>
          </li>
          <li>
            <Link to="/student/profile" className="text-white font-bold hover:text-gray-400">
              Profile
            </Link>
          </li>
          <li>
            <button className="text-white font-bold bg-red-500 hover:bg-red-600 px-4 py-2 rounded-md" onClick={handleLogout}>
              Sign Out
            </button>
          </li>
        </ul>
      </nav>
    </div>
  );
};

export default StudentHeader;
