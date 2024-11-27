import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './components/Home';
import Doctors from './components/Doctors';
import Hospitals from './components/Hospitals';
import Tests from './components/Tests';
import DoctorsResults from './components/DoctorsResults';
import HospitalsResults from './components/HospitalsResults';
import TestResults from './components/TestResults';

import './App.css';
import './input.css';
function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/doctors" element={<Doctors />} />
        <Route path="/hospitals" element={<Hospitals />} />
        <Route path="/tests" element={<Tests />} />
        <Route path="/doctors-results" element={<DoctorsResults />} />
        <Route path="/hospitals-results" element={<HospitalsResults />} />
        <Route path="/tests-results" element={<TestResults />} />
      </Routes>
    </Router>
  );
}

export default App;
