import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import React, { useState, useEffect } from 'react';
import LoginForm from './components/LoginForm';
import RegistrationForm from './components/RegistrationForm';
import AdminRoutes from './routes/AdminRoutes';
import SuperAdminRoutes from './routes/SuperAdminRoutes';
import StudentRoutes from './routes/StudentRoutes';
// import DefaultLayout from './components/SuperAdmin/DefaultLayout'

const App = () => {
  const [role, setRole] = useState(localStorage.getItem('role'));
  const [email, setEmail] = useState(localStorage.getItem('email'));

  useEffect(() => {
    const storedRole = localStorage.getItem('role');
    const storedEmail = localStorage.getItem('email');
    setRole(storedRole);
    setEmail(storedEmail);
  }, []);

  const handleLogin = (role, email) => {
    setRole(role);
    setEmail(email);
    localStorage.setItem('role', role);
    localStorage.setItem('email', email);
  };

  const handleRegister = () => {
    alert('Registration successful! Please login.');
    window.location.href = '/login';
  };

  return (
    <Router>
      <Routes>
        {/* If not logged in, redirect to login */}
        {!role && (
          <>
            <Route path="/login" element={<LoginForm onLogin={handleLogin} />} />
            <Route path="/register" element={<RegistrationForm onRegister={handleRegister} />} />
            <Route path="*" element={<Navigate to="/login" />} />
          </>
        )}

        {/* Admin Routes */}
        {role === 'admin' && (
          <>
            <Route path="/admin/*" element={<AdminRoutes />} />
            <Route path="*" element={<Navigate to="/admin/dashboard" />} />
          </>
        )}

        {/* SuperAdmin Routes */}
        {role === 'superadmin' && (
          <>
            <Route path="/superadmin/*" element={<SuperAdminRoutes />} />
            <Route path="*" element={<Navigate to="/superadmin/layout" />} />

            {/* <Route element={<DefaultLayout />}>
              <Route index element={<ECommerce />} />
              {SuperAdminRoutes.map((routes, index) => {
                const { path, component: Component } = routes;
                return (
                  <Route
                    key={index}
                    path={path}
                    element={
                      <Suspense fallback={<Loader />}>
                        <Component />
                      </Suspense>
                    }
                  />
                );
              })}
            </Route> */}


          </>
        )}

        {/* User Routes */}
        {role === 'student' && (
          <>
            <Route path="/student/*" element={<StudentRoutes />} />
            <Route path="*" element={<Navigate to="/student/dashboard" />} />
          </>
        )}
      </Routes>
    </Router>
  );
};

export default App;
