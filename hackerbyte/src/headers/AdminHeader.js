// import { Link } from 'react-router-dom';
// import React, { useState } from 'react';
// import { useNavigate } from 'react-router-dom'; // Import useNavigate

// const AdminHeader = () => {
//   const [role, setRole] = useState(null);
//   const navigate = useNavigate();
//   // Inline styles
//   const navStyle = {
//     // backgroundColor: '#333333', // Dark gray background for nav
//     padding: '10px 20px',
//     height: '6vh', // Full height
//     marginLeft: '60%',
    
//     justifyContent: 'center',
//   };

//   const ulStyle = {
//     listStyle: 'none', // Remove bullet points
//     display: 'flex', // Display list items in a row
//     justifyContent: 'center',
//     marginTop: '3%',
    
//   };

//   const liStyle = {
//     marginRight: '60px', // Space between links
   
//   };

//   const linkStyle = {
//     color: '#FFFFFF', // White text color
//     textDecoration: 'none', // Remove underline
//     fontWeight: 'bold', // Bold text
//     fontSize: '16px', // Increase font size
//   };

//   const bodyStyle = {
//     backgroundColor: '#000000', // Black background for the body
//     margin: '0',
//     border: '1px solid #ccc',
//     borderRadius: '10px',
//     boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
//     // height: '10vh', // Full height
//   };

//   const handleLogout = async () => {
//     const email = localStorage.getItem('email');
//     console.log(email,"----------------email")
//     try {
//       const response = await fetch('http://localhost:3001/users/sign_out', {
//         method: 'DELETE',
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: JSON.stringify({ email }),
//       });

//       const result = await response.json();
//       console.log(result)
//       if (response.ok) {
//         // Clear local storage or state
//         localStorage.removeItem('role');
//         localStorage.removeItem('email'); // Remove email from local storage
//         setRole(null);
//         window.location.reload();
//         navigate('/user');
//       } else {
//         localStorage.removeItem('role');
//         localStorage.removeItem('email'); // Remove email from local storage
//         setRole(null);
//         window.location.reload();
//         navigate('/user');
        
//       }
//     } catch (error) {
//       console.error('Fetch error:', error);
      
//     }
//   };

//   return (
//     <div style={bodyStyle}>
//       <nav style={navStyle}>
//         <ul style={ulStyle}>
//           <li style={liStyle}>
//             <Link to="/admin/dashboard" style={linkStyle}>Dashboard</Link>
//           </li>
//           <li style={liStyle}>
//             <Link to="/admin/createuser" style={linkStyle}>Create User</Link>
//           </li>
//           <li style={liStyle}>
//             <Link to="/admin/profile" style={linkStyle}>Profile</Link>
//           </li>
//           <li style={liStyle}>
//             <button style={{color: 'blue',backgroundColor: 'red',borderRadius: '5px'}} onClick={handleLogout}>Sign Out</button>
//           </li>
//         </ul>
//       </nav>
//     </div>
//   );
// };

// export default AdminHeader;


import { Link } from 'react-router-dom';
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const AdminHeader = () => {
  const [role, setRole] = useState(null);
  const navigate = useNavigate();

  // Inline styles
  const navStyle = {
    padding: '10px 20px',
    height: '6vh',
    display: 'flex',
    justifyContent: 'flex-end',
    alignItems: 'center',
    backgroundColor: '#333', // Background color for nav
    position: 'relative', // To help with dropdown positioning
  };

  const ulStyle = {
    listStyle: 'none',
    display: 'flex',
    justifyContent: 'space-around',
    alignItems: 'center',
    margin: '0',
    padding: '0',
    flexDirection: 'coloumn', // Default to row layout
  };

  const liStyle = {
    marginRight: '20px',
  };

  const linkStyle = {
    color: '#FFFFFF',
    textDecoration: 'none',
    fontWeight: 'bold',
    fontSize: '16px',
  };

  const buttonStyle = {
    color: '#fff',
    backgroundColor: 'red',
    borderRadius: '5px',
    padding: '5px 10px',
    border: 'none',
    cursor: 'pointer',
  };

  const dropdownButtonStyle = {
    color: '#fff',
    backgroundColor: 'blue',
    borderRadius: '5px',
    padding: '5px 10px',
    border: 'none',
    cursor: 'pointer',
    display: 'none', // Hidden by default, shown on small screens
  };

  const bodyStyle = {
    backgroundColor: '#000000',
    margin: '0',
    border: '1px solid #ccc',
    borderRadius: '10px',
    boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
  };

  const handleLogout = async () => {
    const email = localStorage.getItem('email');
    console.log(email,"----------------email")
    try {
      const response = await fetch('http://localhost:3001/users/sign_out', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email }),
      });

      const result = await response.json();
      console.log(result)
      if (response.ok) {
        // Clear local storage or state
        localStorage.removeItem('role');
        localStorage.removeItem('email'); // Remove email from local storage
        setRole(null);
        window.location.reload();
        navigate('/user');
      } else {
        localStorage.removeItem('role');
        localStorage.removeItem('email'); // Remove email from local storage
        setRole(null);
        window.location.reload();
        navigate('/user');
        
      }
    } catch (error) {
      console.error('Fetch error:', error);
      
    }
  };

  // Media queries applied via JavaScript
  const mediaQuery = window.matchMedia('(max-width: 768px)');

  if (mediaQuery.matches) {
    ulStyle.flexDirection = 'column'; // Stack items vertically
    ulStyle.alignItems = 'flex-start'; // Align items to start
    dropdownButtonStyle.display = 'block'; // Show dropdown button
    navStyle.flexDirection = 'column'; // Stack nav items vertically
  }

  return (
    <div style={bodyStyle}>
      <nav style={navStyle}>
        <button style={dropdownButtonStyle}>Menu</button>
        <ul style={ulStyle}>
          <li style={liStyle}>
            <Link to="/admin/dashboard" style={linkStyle}>Dashboard</Link>
          </li>
          <li style={liStyle}>
            <Link to="/admin/createuser" style={linkStyle}>Create User</Link>
          </li>
          <li style={liStyle}>
            <Link to="/admin/profile" style={linkStyle}>Profile</Link>
          </li>
          <li style={liStyle}>
            <button style={buttonStyle} onClick={handleLogout}>Sign Out</button>
          </li>
        </ul>
      </nav>
    </div>
  );
};

export default AdminHeader;
