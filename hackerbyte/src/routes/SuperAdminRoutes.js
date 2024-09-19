import React from 'react';
// import { Route, Routes } from 'react-router-dom';
// import SuperAdminHeader from '../headers/SuperAdminHeader';



import { lazy } from 'react';

const Dashboard = lazy(() => import('../components/SuperAdmin/Dashboard'));

const Profile = lazy(() => import('../components/SuperAdmin/Profile'));

const CreateAdmin = lazy(() => import('../components/SuperAdmin/CreateAdmin'));

const DefaultLayout = lazy(() => import('../components/SuperAdmin/DefaultLayout'));

// import Dashboard from '../components/SuperAdmin/Dashboard';
// import Profile from '../components/SuperAdmin/Profile';
// import CreateAdmin from '../components/SuperAdmin/CreateAdmin';
// import DefaultLayout from  '../components/SuperAdmin/DefaultLayout';

// const SuperAdminRoutes = () => (
//   <>
//     {/* <SuperAdminHeader /> */}
//     <Routes>
//       <Route path="layout" element={<DefaultLayout />} />
//       <Route path="/layout/dashboard" element={<Dashboard />} />
//       <Route path="profile" element={<Profile />} />
//       <Route path="createadmin" element={<CreateAdmin />} />
      
//     </Routes>
//   </>
// );

// export default SuperAdminRoutes;



const coreRoutes = [
  {
    path: '/dashboard',
    title: 'dashboard',
    component: Dashboard,
  },
  {
    path: '/layout',
    title: 'layout',
    component: DefaultLayout,
  },

  {
    path: '/profile',
    title: 'profile',
    component: Profile,
  },
  
  {
    path: '/createadmin',
    title: 'createadmin',
    component: CreateAdmin,
  },

];

const SuperAdminRoutes = [...coreRoutes];
export default SuperAdminRoutes;