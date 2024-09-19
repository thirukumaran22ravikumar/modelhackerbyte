import { useState } from 'react';
import Header from '../SuperAdmin/Header';
import Sidebar from '../SuperAdmin/Sidebar';
import { Outlet } from 'react-router-dom';
import React from "react";



const DefaultLayout = () => {
  const [sidebarOpen, setSidebarOpen] = useState(false);

  return (
    <div className="dark:bg-boxdark-2 dark:text-bodydark">
      


      <div className="flex h-screen overflow-hidden">
        <Sidebar  sidebarOpen={sidebarOpen} setSidebarOpen={setSidebarOpen} />
        <h1>Sidebar</h1>
        {/* <!-- ===== Content Area Start ===== --> */}
        <div className="relative flex flex-1 flex-col overflow-y-auto overflow-x-hidden">
          <Header  sidebarOpen={sidebarOpen} setSidebarOpen={setSidebarOpen} />
          <h1>Headerqw1Z</h1>
          <main>
            <div className="mx-auto max-w-screen-2xl p-4 md:p-6 2xl:p-10">
              <Outlet />
            </div>
          </main>
          {/* <!-- ===== Main Content End ===== --> */}
        </div>
        {/* <!-- ===== Content Area End ===== --> */}
      </div>
      {/* <!-- ===== Page Wrapper End ===== --> */}
    </div>
    
  );
};

export default DefaultLayout;
