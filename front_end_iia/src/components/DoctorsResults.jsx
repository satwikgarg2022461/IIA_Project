import { Card, ConfigProvider, theme, Descriptions, Button } from "antd";
import { useState } from "react";
import { ArrowLeftOutlined } from '@ant-design/icons'; // Importing the back arrow icon

const DoctorResults = () => {
  // Dummy data
  const response = {
    bestMatch: {
      Name: "Dr. Priya Verma",
      Specialization: "Dermatology",
      ContactNumber: "9876543210",
      Address: "456 Skin Care Road, New Delhi, India",
      Email: "drpriya@dermahealth.com",
      AvailableTimes: [
        { Date: "2024-11-10", Time: "09:00", Price: 1800 },
        { Date: "2024-11-11", Time: "14:00", Price: 2000 },
      ],
    },
  };

  const { bestMatch } = response;

  const [selectedDoctor] = useState(bestMatch);

  const handleBackClick = () => {
    window.history.back(); // Navigates to the previous page
  };

  return (
    <ConfigProvider
      theme={{
        algorithm: theme.darkAlgorithm,
        token: {
          colorBgContainer: "#121212",
          colorText: "#e0e0e0",
          colorBorder: "#333333",
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
            Health Compass - Doctor Details
          </h1>
        </header>

        <div className="flex-grow flex items-center justify-center bg-gray-950">
          <div className="w-full max-w-3xl">
            <div className="bg-gray-800 border border-gray-700 shadow-2xl rounded-lg p-6">
              <h2 className="text-xl font-semibold text-gray-100 mb-4">
                Doctor Details
              </h2>
              <Card
                className="shadow-lg bg-gray-900 border-gray-800 text-gray-100"
                bodyStyle={{ padding: "1rem" }}
              >
                <Descriptions
                  title={<span className="text-lg font-bold text-blue-500">{selectedDoctor.Name}</span>}
                  column={1}
                  size="small"
                  bordered
                  labelStyle={{
                    color: "#a3a3a3",
                    fontWeight: "bold",
                  }}
                  contentStyle={{
                    color: "#f3f4f6",
                  }}
                >
                  <Descriptions.Item label="Specialization">
                    {selectedDoctor.Specialization}
                  </Descriptions.Item>
                  <Descriptions.Item label="Contact Number">
                    {selectedDoctor.ContactNumber}
                  </Descriptions.Item>
                  <Descriptions.Item label="Email">
                    {selectedDoctor.Email}
                  </Descriptions.Item>
                  <Descriptions.Item label="Address">
                    {selectedDoctor.Address}
                  </Descriptions.Item>
                </Descriptions>

                {/* Available Times */}
                <div>
                  <h4 className="text-md font-medium text-green-500 mt-6 mb-2">
                    Available Appointment Times
                  </h4>
                  {selectedDoctor.AvailableTimes.map((appointment, aIndex) => (
                    <Card
                      key={aIndex}
                      className="bg-gray-900 mb-6 border-gray-700"
                      bodyStyle={{ padding: "1rem" }}
                    >
                      <div className="text-gray-100">
                        <p className="font-medium mb-2">
                          <strong>Date:</strong> {appointment.Date} |{" "}
                          <strong>Time:</strong> {appointment.Time} |{" "}
                          <strong>Price:</strong> ₹{appointment.Price}
                        </p>
                      </div>
                    </Card>
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

export default DoctorResults;
