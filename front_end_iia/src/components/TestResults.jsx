import { Card, ConfigProvider, theme, Descriptions, Button } from "antd";
import { ArrowLeftOutlined } from "@ant-design/icons";
import { useLocation } from "react-router-dom";

const TestResults = () => {
  // Extract test results from route state
  const location = useLocation();
  const { results } = location.state || { testResults: [] };

  // Group test results by test name and hospital
  const groupedTests = results.reduce((accumulator, test) => {
    const { t_name, description, cost, date, time, status, hospital_name } = test;
    const groupKey = `${t_name}-${hospital_name}`;

    // Group by unique test and hospital combination
    if (accumulator[groupKey]) {
      accumulator[groupKey].appointments.push({ date, time, status, cost });
    } else {
      accumulator[groupKey] = {
        testName: t_name,
        description,
        hospitalName: hospital_name,
        appointments: [{ date, time, status, cost }],
      };
    }

    return accumulator;
  }, {});

  const groupedTestsList = Object.values(groupedTests);

  // Handle back button click
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
        {/* Header */}
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
            Available Tests
          </h1>
        </header>

        {/* Test Details Section */}
        <div className="flex-grow flex items-center justify-center bg-gray-950">
          <div className="w-full max-w-3xl">
            <div className="bg-gray-800 border border-gray-700 shadow-2xl rounded-lg p-6">
              <h2 className="text-xl font-semibold text-gray-100 mb-4">
                Test Details
              </h2>
              {groupedTestsList.map((test, index) => (
                <Card
                  key={index}
                  className="shadow-lg bg-gray-900 border-gray-800 text-gray-100 mb-4"
                  bodyStyle={{ padding: "1rem" }}
                >
                  {/* Test Info */}
                  <Descriptions
                    title={
                      <span className="text-lg font-bold text-blue-500">
                        {test.testName}
                      </span>
                    }
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
                    <Descriptions.Item label="Description">
                      {test.description}
                    </Descriptions.Item>
                    <Descriptions.Item label="Hospital">
                      {test.hospitalName}
                    </Descriptions.Item>
                  </Descriptions>

                  {/* Appointment Slots */}
                  <div>
                    <h4 className="text-md font-medium text-green-500 mt-6 mb-2">
                      Available Slots
                    </h4>
                    {test.appointments.map((appointment, slotIndex) => (
                      <Card
                        key={slotIndex}
                        className="bg-gray-900 mb-4 border-gray-700"
                        bodyStyle={{ padding: "1rem" }}
                      >
                        <div className="text-gray-100">
                          <p className="text-sm mb-1">
                            <strong>Date:</strong> {appointment.date}
                          </p>
                          <p className="text-sm mb-1">
                            <strong>Time:</strong> {appointment.time}
                          </p>
                          <p className="text-sm">
                            <strong>Status:</strong> {appointment.status} |{" "}
                            <strong>Cost:</strong> ₹{appointment.cost}
                          </p>
                        </div>
                      </Card>
                    ))}
                  </div>
                </Card>
              ))}
            </div>
          </div>
        </div>

        {/* Footer */}
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

export default TestResults;
