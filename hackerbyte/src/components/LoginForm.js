import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const LoginForm = ({ onLogin }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const navigate = useNavigate(); // useNavigate is now used correctly

  const handleSubmit = async (event) => {
    event.preventDefault();

    try {
      const response = await fetch('http://localhost:3001/users/sign_in', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, password }),
      });

      const text = await response.text();
      console.log('Response Text:', text);

      let data;
      try {
        data = JSON.parse(text);
      } catch (jsonError) {
        console.error('Failed to parse JSON:', jsonError);
        alert('Failed to parse server response.');
        return;
      }

      if (response.ok) {
        onLogin(data.user.role, data.user.email);

        if (data.user.role === 'admin') {
          navigate('/admin/dashboard'); // Redirect to admin page
        } else if (data.user.role === 'user') {
          navigate('/student/dashboard'); // Redirect to user page
        } else if(data.user.role === 'superadmin'){
          navigate('/superadmin/dashboard'); // Redirect to user page
        } 
      } else {
        alert(`Login failed: ${data.errors.join(', ')}`);
      }
    } catch (error) {
      console.error('Fetch error:', error);
      alert('An unexpected error occurred.');
    }
  };

  // Inline CSS styles
  const formStyle = {
    maxWidth: '400px',
    margin: '50px auto',
    padding: '20px',
    border: '1px solid #ccc',
    borderRadius: '10px',
    backgroundColor: '#f9f9f9',
    boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)',
  };

  const fieldStyle = {
    marginBottom: '15px',
    display: 'flex',
    flexDirection: 'column',
  };

  const labelStyle = {
    marginBottom: '5px',
    fontWeight: 'bold',
  };

  const inputStyle = {
    padding: '10px',
    fontSize: '16px',
    borderRadius: '5px',
    border: '1px solid #ccc',
  };

  const buttonStyle = {
    padding: '10px',
    fontSize: '16px',
    borderRadius: '5px',
    border: 'none',
    backgroundColor: '#4CAF50',
    color: '#fff',
    cursor: 'pointer',
    width: '100%',
  };

  return (
    <form onSubmit={handleSubmit} style={formStyle}>
      <div style={fieldStyle}>
        <label style={{fontWeight: 'bold',textAlign:'center'}}>LOG IN</label>
      </div>
      <div style={fieldStyle}>
        <label style={labelStyle}>Email:</label>
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
          style={inputStyle}
        />
      </div>
      <div style={fieldStyle}>
        <label style={labelStyle}>Password:</label>
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
          style={inputStyle}
        />
      </div>
      <button type="submit" style={buttonStyle}>Login</button>
    </form>
  );
};

export default LoginForm;
