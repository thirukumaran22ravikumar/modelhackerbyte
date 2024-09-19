import React from 'react';
import { Route, Routes } from 'react-router-dom';

import StudentHeader from '../headers/StudentHeader';
import Dashboard from '../components/Student/Dashboard';
import Profile from '../components/Student/Profile';
import Course from '../components/Student/Course';

const StudentRoutes = () => (
  <>
    <StudentHeader />
    <Routes>
      <Route path="dashboard" element={<Dashboard />} />
      <Route path="profile" element={<Profile />} />
      <Route path="course" element={<Course />} />
    </Routes>
  </>
);

export default StudentRoutes;
