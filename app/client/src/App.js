import React, { useState, useEffect } from 'react';

function App() {
  const [data, setData] = useState({}); // Assuming the expected data is an object

  useEffect(() => {
    fetch("/hello")
      .then(res => res.json()
      )
      .then(data => {
        setData(data);
        console.log(data);
      })
      .catch(error => console.error("Fetch error:", error)); // Error handling
  }, []); // Dependency array is empty, indicating this effect runs once on mount

  return (
    <div>
      {typeof data.yeahboi === "undefined" ? (
        <p>Loading...</p> // Displaying a loading message instead of trying to render `data` directly
      ) : (
        data.yeahboi.map((yeahboi, i) => <p key={i}>{yeahboi}</p>)
      )}
    </div>
  );
}

export default App;
