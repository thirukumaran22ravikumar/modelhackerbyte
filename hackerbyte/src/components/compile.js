import React, { useState } from 'react';
import AceEditor from 'react-ace';
import 'ace-builds/src-noconflict/mode-html';
import 'ace-builds/src-noconflict/mode-css';
import 'ace-builds/src-noconflict/mode-javascript';
import 'ace-builds/src-noconflict/theme-monokai';

function Compile() {
  const [htmlCode, setHtmlCode] = useState('<h1>Hello, World!</h1>');
  const [cssCode, setCssCode] = useState('h1 { color: red; }');
  const [jsCode, setJsCode] = useState('console.log("Hello, World!");');

  const generateOutput = () => {
    const iframe = document.getElementById('output-frame');
    const documentContent = `
      <html>
        <head>
          <style>${cssCode}</style>
        </head>
        <body>
          ${htmlCode}
          <script>${jsCode}</script>
        </body>
      </html>
    `;

    iframe.srcdoc = documentContent;
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'row', alignItems: 'center' }}>
      <h3>HTML</h3>
      <AceEditor
        mode="html"
        theme="monokai"
        onChange={setHtmlCode}
        value={htmlCode}
        name="html-editor"
        editorProps={{ $blockScrolling: true }}
        width="600px"
        height="200px"
      />
      <h3>CSS</h3>
      <AceEditor
        mode="css"
        theme="monokai"
        onChange={setCssCode}
        value={cssCode}
        name="css-editor"
        editorProps={{ $blockScrolling: true }}
        width="600px"
        height="200px"
      />
      <h3>JavaScript</h3>
      <AceEditor
        mode="javascript"
        theme="monokai"
        onChange={setJsCode}
        value={jsCode}
        name="js-editor"
        editorProps={{ $blockScrolling: true }}
        width="600px"
        height="200px"
      />
      <button onClick={generateOutput} style={{ marginTop: '10px' }}>
        Run Code
      </button>
      <h3>Output</h3>
      <iframe
        id="output-frame"
        title="Output"
        style={{
          width: '600px',
          height: '400px',
          border: '1px solid #ccc',
          marginTop: '10px',
        }}
      />
    </div>
  );
}

export default Compile;

