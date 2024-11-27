import { Card, ConfigProvider, theme, Descriptions, Button } from "antd";
import { ArrowLeftOutlined } from "@ant-design/icons"; // Importing the back arrow icon
import { useLocation } from "react-router-dom"; // Importing useLocation for accessing state

const HospitalResults = () => {
  const location = useLocation();
  const { results } = location.state || { results: [] };

  console.log("Received Results:", results);

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

        {/* Main Content */}
        <div className="flex-grow flex flex-col items-center bg-gray-950 px-4 py-8">
          <h2 className="text-xl font-semibold text-gray-100 mb-6">
            Hospital Search Results
          </h2>
          <div className="w-full max-w-5xl grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {results.length > 0 ? (
              results.map((hospital, index) => (
                <Card
                  key={index}
                  className="shadow-lg bg-gray-900 border-gray-800 text-gray-100"
                  bodyStyle={{ padding: "1rem" }}
                >
                  <Descriptions
                    title={
                      <span className="text-lg font-bold text-blue-500">
                        {hospital.hospital_name ?? "None"}
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
                      {hospital.hospital_speciality ?? "None"}
                    </Descriptions.Item>
                    <Descriptions.Item label="Email">
                      {hospital.hospital_email ?? "None"}
                    </Descriptions.Item>
                    <Descriptions.Item label="Address">
                      {hospital.hospital_address ?? "None"}
                    </Descriptions.Item>
                  </Descriptions>
                </Card>
              ))
            ) : (
              <div className="text-gray-300 text-lg">No results found.</div>
            )}
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
