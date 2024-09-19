import React, { useState } from 'react';
import AceEditor from 'react-ace';
import axios from 'axios';
import 'ace-builds/src-noconflict/mode-javascript';
import 'ace-builds/src-noconflict/theme-monokai';

function CodeWindow() {
  const [code, setCode] = useState("console.log('Hello, World!');");
  const [output, setOutput] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleCompile = async () => {
    setIsLoading(true);
    try {
      const result = await executeCode('javascript', code);
      setOutput(result.run.stdout || result.run.stderr || 'No output');
    } catch (error) {
      setOutput('An error occurred while executing the code.');
    } finally {
      setIsLoading(false);
    }
  };

  async function executeCode(language, code) {
    executeRuntimeLanguage()
    const endpoint = "https://emkc.org/api/v2/piston/execute";
    const requestData = {
      language: language, // Ensure this is 'js' for JavaScript
      version: '18.15.0', // Specify the version
      files: [
        {
          name: "my_cool_code.js", // File name as specified
          content: code, // The code to be executed
        },
      ],
    };
  
    console.log('Request Data:', requestData);
  
    try {
      const response = await axios.post(endpoint, requestData, {
        headers: {
          'Content-Type': 'application/json',
        },
      });
      console.log('Response Data:', response.data);
      return response.data;
    } catch (error) {
      if (error.response) {
        // The request was made and the server responded with a status code
        console.error('Response Error:', error.response.data);
      } else if (error.request) {
        // The request was made but no response was received
        console.error('Request Error:', error.request);
      } else {
        // Something happened in setting up the request that triggered an Error
        console.error('Error Message:', error.message);
      }
      throw error;
    }
  }
  async function executeRuntimeLanguage() {
    const response = await axios.get("https://emkc.org/api/v2/piston/runtimes")
    console.log("after execute")
    console.log(response)
    return response.data;
  } 

  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
      <AceEditor
        mode="javascript"
        theme="monokai"
        onChange={setCode}
        value={code}
        name="code-editor"
        editorProps={{ $blockScrolling: true }}
        setOptions={{
          useWorker: false,  // Disable the Web Worker
        }}
        width="600px"
        height="400px"
      />
      <button onClick={handleCompile} disabled={isLoading} style={{ marginTop: '10px' }}>
        {isLoading ? 'Running...' : 'Run Code'}
      </button>
      <div style={{ marginTop: '20px', width: '600px', backgroundColor: '#1e1e1e', color: '#ffffff', padding: '10px', borderRadius: '5px' }}>
        <h3>Output:</h3>
        <pre>{output}</pre>
      </div>
    </div>
  );
}

export default CodeWindow;
