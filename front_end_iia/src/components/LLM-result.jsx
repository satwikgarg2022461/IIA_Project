// Import necessary libraries
import React from "react";
import { ConfigProvider, theme, Card, Button } from "antd";
import { ArrowLeftOutlined } from "@ant-design/icons";
import { useLocation } from "react-router-dom";

const LlmResult = () => {
    const location = useLocation();
    // Extract and handle the results data safely
    let { results = [] } = location.state || {};
    console.log("Raw results:", results);

    // Ensure `results` is correctly accessed
    results = results?.results || [];
    console.log("Processed results:", results);

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
                <header className="w-full py-4 bg-gray-800 border-b border-gray-700 flex items-center">
                    <Button
                        icon={<ArrowLeftOutlined />}
                        onClick={handleBackClick}
                        type="link"
                        className="text-white"
                    >
                        Back
                    </Button>
                    <h1 className="text-white text-center text-xl flex-grow">
                        LLM Results
                    </h1>
                </header>

                {/* Results Section */}
                <main className="flex-grow flex flex-col items-center bg-gray-950 p-6">
                    {results.map((item, index) => (
    <Card
        key={index}
        className="bg-gray-800 border border-gray-700 text-gray-400"
    >
        {Object.entries(item).map(([key, value]) => (
            <p key={key}>
                <strong>{key}:</strong> {value}
            </p>
        ))}
    </Card>
))}
                </main>

                {/* Footer */}
                <footer className="w-full py-2 bg-gray-800 border-t border-gray-700 text-gray-400 text-sm flex justify-between px-6">
                    <span className="hover:text-blue-500 transition cursor-pointer">
                        Terms & Conditions
                    </span>
                    <span className="hover:text-green-500 transition cursor-pointer">
                        Help/Contact
                    </span>
                </footer>
            </div>
        </ConfigProvider>
    );
};

export default LlmResult;
