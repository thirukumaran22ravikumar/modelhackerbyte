// src/components/RegistrationForm.js
import React, { useState } from 'react';

const RegistrationForm = ({ onRegister }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [passwordConfirmation, setPasswordConfirmation] = useState('');
  const [role, setRole] = useState('user');

  const handleSubmit = async (event) => {
    event.preventDefault();
  
    try {
      const response = await fetch('http://localhost:3001/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          user: {
            email,
            password,
            password_confirmation: passwordConfirmation,
            role,
          },
        }),
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
        localStorage.setItem('role', data.role); // Store the role
        onRegister();
      } else {
        alert(`Registration failed: ${data.errors.join(', ')}`);
      }
    } catch (error) {
      console.error('Fetch error:', error);
      alert('An unexpected error occurred.');
    }
  };
  

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label>Email:</label>
        <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
      </div>
      <div>
        <label>Password:</label>
        <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
      </div>
      <div>
        <label>Confirm Password:</label>
        <input type="password" value={passwordConfirmation} onChange={(e) => setPasswordConfirmation(e.target.value)} required />
      </div>
      <div>
        <label>Role:</label>
        <select value={role} onChange={(e) => setRole(e.target.value)}>
          <option value="user">User</option>
          <option value="admin">Admin</option>
        </select>
      </div>
      <button type="submit">Register</button>
    </form>
  );
};

export default RegistrationForm;
