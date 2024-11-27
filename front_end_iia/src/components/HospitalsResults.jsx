import { Card, ConfigProvider, theme, Descriptions, Button } from "antd";
import { useState } from "react";
import { ArrowLeftOutlined } from '@ant-design/icons'; // Importing the back arrow icon // Importing useHistory for navigation (if using React Router)
import HospitalLogo from "../assets/hospital_svg.png"; // Example image (replace as needed)

const HospitalResults = () => {
  // Dummy data
  const response = {
    bestMatch: {
      Name: "Delhi Health Center",
      Specialization: "General Healthcare",
      ContactNumber: "9876543210",
      Address: "123 Health St, New Delhi, India",
      Email: "contact@delhihealth.com",
      Doctors: [
        {
          Name: "Dr. Rajesh Kumar",
          Specialization: "Cardiology",
          AppointmentDetails: [
            { AppointmentPrice: 2200, Date: "2024-11-08", Time: "10:00" },
            { AppointmentPrice: 3500, Date: "2024-11-09", Time: "14:00" },
          ],
        },
      ],
    },
  };

  const { bestMatch } = response;

  // State for the selected hospital
  const [selectedHospital] = useState(bestMatch);

  // Using useHistory hook for navigation (if using React Router)
  // Function to handle back button click
  const handleBackClick = () => {
    window.history.back(); // Navigates to the previous page
  };

  return (
    <ConfigProvider
      theme={{
        algorithm: theme.darkAlgorithm,
        token: {
          colorBgContainer: "#121212", // Dark background
          colorText: "#e0e0e0", // Light text color
          colorBorder: "#333333", // Dark border color
        },
      }}
    >
      <div className="min-h-screen flex flex-col bg-gray-950">
        {/* Header Section */}
        <header className="w-full py-4 bg-gray-800 border-b border-gray-700 shadow-lg flex items-center">
          <Button
            icon={<ArrowLeftOutlined />}
            onClick={handleBackClick}
            className="text-white mr-4"
            type="link"
          >
            Back
          </Button>
          <h1 className="text-center text-white text-2xl tracking-wide flex-grow">
            Welcome to Health Compass
          </h1>
        </header>

        <div className="flex-grow flex items-center justify-center bg-gray-950">
          <div className="w-full max-w-3xl">
            <div className="bg-gray-800 border border-gray-700 shadow-2xl rounded-lg p-6">
              <h2 className="text-xl font-semibold text-gray-100 mb-4">
                Hospital Details
              </h2>
              <Card
                className="shadow-lg bg-gray-900 border-gray-800 text-gray-100"
                bodyStyle={{ padding: "1rem" }}
              >
                <Descriptions
                  title={
                    <span className="text-lg font-bold text-blue-500">
                      {selectedHospital.Name}
                    </span>
                  }
                  column={1}
                  size="small"
                  bordered
                  labelStyle={{
                    color: "#a3a3a3", // Tailwind gray-400
                    fontWeight: "bold",
                  }}
                  contentStyle={{
                    color: "#f3f4f6", // Tailwind gray-100
                  }}
                >
                  <Descriptions.Item label="Specialization">
                    {selectedHospital.Specialization}
                  </Descriptions.Item>
                  <Descriptions.Item label="Contact Number">
                    {selectedHospital.ContactNumber}
                  </Descriptions.Item>
                  <Descriptions.Item label="Email">
                    {selectedHospital.Email}
                  </Descriptions.Item>
                  <Descriptions.Item label="Address">
                    {selectedHospital.Address}
                  </Descriptions.Item>
                </Descriptions>

                {/* Doctors */}
                <div>
                  <h4 className="text-md font-medium text-green-500 mt-6 mb-2">
                    Available Appointments
                  </h4>
                  {selectedHospital.Doctors.map((doctor, dIndex) => (
                    <div key={dIndex}>
                      {doctor.AppointmentDetails.map((appointment, aIndex) => (
                        <Card
                          key={aIndex}
                          className="bg-gray-900 mb-6 border-gray-700"
                          bodyStyle={{ padding: "1rem" }}
                        >
                          <div className="text-gray-100">
                            <p className="font-medium mb-2">
                              <strong>Doctor:</strong> {doctor.Name}
                            </p>
                            <p className="font-medium mb-2">
                              <strong>Specialization:</strong>{" "}
                              {doctor.Specialization}
                            </p>
                            <p className="text-sm mb-2">
                              <strong>Date:</strong> {appointment.Date} |{" "}
                              <strong>Time:</strong> {appointment.Time} |{" "}
                              <strong>Price:</strong> ₹
                              {appointment.AppointmentPrice}
                            </p>
                          </div>
                        </Card>
                      ))}
                    </div>
                  ))}
                </div>
              </Card>
            </div>
          </div>
        </div>

        {/* Footer Section */}
        <footer className="w-full bg-gray-800 border-t border-gray-700 py-2 flex justify-between px-6 text-gray-400 text-sm shadow-lg mt-auto">
          <span className="hover:text-blue-500 transition duration-300 cursor-pointer">
            Terms & Conditions
          </span>
          <span className="hover:text-green-500 transition duration-300 cursor-pointer">
            Help/Contact
          </span>
        </footer>
      </div>
    </ConfigProvider>
  );
};

export default HospitalResults;
