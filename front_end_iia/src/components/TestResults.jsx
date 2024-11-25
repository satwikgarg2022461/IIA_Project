import { Card, ConfigProvider, theme, Descriptions, Button } from "antd";
import { ArrowLeftOutlined } from "@ant-design/icons";
import { useState } from "react";

const TestsResults = () => {
  // Dummy data for tests
  const response = {
    bestMatch: {
      TestName: "Comprehensive Health Screening",
      Price: 4500,
      Description:
        "A complete health check-up package covering essential health markers.",
      AvailableSlots: [
        { Date: "2024-11-10", Time: "09:00" },
        { Date: "2024-11-11", Time: "11:30" },
      ],
    },
  };

  const { bestMatch } = response;

  const [selectedTest] = useState(bestMatch);

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

        <div className="flex-grow flex items-center justify-center bg-gray-950">
          <div className="w-full max-w-3xl">
            <div className="bg-gray-800 border border-gray-700 shadow-2xl rounded-lg p-6">
              <h2 className="text-xl font-semibold text-gray-100 mb-4">
                Test Details
              </h2>
              <Card
                className="shadow-lg bg-gray-900 border-gray-800 text-gray-100"
                bodyStyle={{ padding: "1rem" }}
              >
                <Descriptions
                  title={
                    <span className="text-lg font-bold text-blue-500">
                      {selectedTest.TestName}
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
                    {selectedTest.Description}
                  </Descriptions.Item>
                  <Descriptions.Item label="Price">
                    ₹{selectedTest.Price}
                  </Descriptions.Item>
                </Descriptions>

                <div>
                  <h4 className="text-md font-medium text-green-500 mt-6 mb-2">
                    Available Slots
                  </h4>
                  {selectedTest.AvailableSlots.map((slot, index) => (
                    <Card
                      key={index}
                      className="bg-gray-900 mb-6 border-gray-700"
                      bodyStyle={{ padding: "1rem" }}
                    >
                      <div className="text-gray-100">
                        <p className="text-sm mb-2">
                          <strong>Date:</strong> {slot.Date} |{" "}
                          <strong>Time:</strong> {slot.Time}
                        </p>
                      </div>
                    </Card>
                  ))}
                </div>
              </Card>
            </div>
          </div>
        </div>

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

export default TestsResults;
