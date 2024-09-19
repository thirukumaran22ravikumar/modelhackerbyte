import React from 'react';
import { Route, Routes } from 'react-router-dom';
import AdminHeader from '../headers/AdminHeader';
import Dashboard from '../components/Admin/Dashboard';
import Profile from '../components/Admin/Profile';
import CreateUser from '../components/Admin/CreateUser';

const AdminRoutes = () => (
  <>
    <AdminHeader />
    <Routes>
      <Route path="dashboard" element={<Dashboard />} />
      <Route path="profile" element={<Profile />} />
      <Route path="createuser" element={<CreateUser />} />
    </Routes>
  </>
);

export default AdminRoutes;
