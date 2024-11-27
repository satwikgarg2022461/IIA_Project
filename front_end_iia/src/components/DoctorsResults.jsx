import { Card, ConfigProvider, theme, Descriptions, Button } from "antd";
import { useState } from "react";
import { ArrowLeftOutlined } from '@ant-design/icons';
import { useLocation } from "react-router-dom";

const DoctorResults = () => {
  const location = useLocation();
  const { results } = location.state || { results: [] };

  // Group appointments by doctor
  // Grouping the doctors
const groupedDoctors = results.reduce((acc, doctor) => {
  const { d_name, email, phone, date, time, status, price } = doctor;

  // Unique key to identify a doctor
  const key = `${d_name}-${email}-${phone}`;

  // If doctor already exists in the accumulator, push appointment details
  if (acc[key]) {
    acc[key].appointments.push({ date, time, status, price });
  } else {
    // Add new doctor entry with their initial appointment
    acc[key] = {
      d_name,
      email,
      phone,
      education: doctor.education,
      experience: doctor.experience,
      hospital_name: doctor.hospital_name,
      speciality: doctor.speciality,
      appointments: [{ date, time, status, price }],
    };
  }

  return acc;
}, {});

// Converting the result to an array
const doctorsList = Object.values(groupedDoctors);

console.log(doctorsList);

  const handleBackClick = () => {
    window.history.back();
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
            {doctorsList.map((doctor) => (
              <div
                key={doctor.d_id}
                className="bg-gray-800 border border-gray-700 shadow-2xl rounded-lg p-6 mb-6"
              >
                <h2 className="text-xl font-semibold text-gray-100 mb-4">
                  Doctor Details
                </h2>
                <Card
                  className="shadow-lg bg-gray-900 border-gray-800 text-gray-100"
                  bodyStyle={{ padding: "1rem" }}
                >
                  <Descriptions
                    title={<span className="text-lg font-bold text-blue-500">{doctor.d_name}</span>}
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
                      {doctor.speciality}
                    </Descriptions.Item>
                    <Descriptions.Item label="Contact Number">
                      {doctor.phone}
                    </Descriptions.Item>
                    <Descriptions.Item label="Email">
                      {doctor.email}
                    </Descriptions.Item>
                    <Descriptions.Item label="Education">
                      {doctor.education}
                    </Descriptions.Item>
                    <Descriptions.Item label="Hospital Name">
                      {doctor.hospital_name}
                    </Descriptions.Item>
                    <Descriptions.Item label="Price">
                      ₹{doctor.price}
                    </Descriptions.Item>
                    <Descriptions.Item label="Experience">
                      {doctor.experience || "N/A"}
                    </Descriptions.Item>
                  </Descriptions>

                  {/* Appointments Section */}
                  <div>
                    <h4 className="text-md font-medium text-green-500 mt-6 mb-2">
                      Available Appointment Times
                    </h4>
                    {doctor.appointments.length > 0 ? (
                      doctor.appointments.map((appointment, aIndex) => (
                        <Card
                          key={aIndex}
                          className="bg-gray-900 mb-6 border-gray-700"
                          bodyStyle={{ padding: "1rem" }}
                        >
                          <div className="text-gray-100">
                            <p className="font-medium mb-2">
                              <strong>Date:</strong> {appointment.date} |{" "}
                              <strong>Time:</strong> {appointment.time || "Not Available"}
                            </p>
                            <p className="text-sm">
                              <strong>Status:</strong> {appointment.status || "N/A"} |{" "}
                              <strong>Price:</strong> ₹{appointment.price}
                            </p>
                          </div>
                        </Card>
                      ))
                    ) : (
                      <p className="text-gray-400">No appointments available</p>
                    )}
                  </div>
                </Card>
              </div>
            ))}
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
