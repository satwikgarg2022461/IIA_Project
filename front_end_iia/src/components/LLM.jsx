import { ConfigProvider, theme, Input, Button, Form } from "antd"; // Ant Design components
import { ArrowLeftOutlined } from "@ant-design/icons"; // Ant Design icon
import { useNavigate } from "react-router-dom"; // React Router for navigation
import axios from "axios"; // Axios for API calls

const LLM = () => {
    const [formInstance] = Form.useForm(); // Changed variable name for clarity
    const navigateToPage = useNavigate(); // Changed variable name for clarity

    const handleFormSubmit = () => {
        formInstance.validateFields()
            .then(inputValues => {
                const { query } = inputValues; // Adjusted to match LLM context

                if (!query) {
                    alert("Please enter a query.");
                    return;
                }

                const requestPayload = { query }; // Adjusted variable name

                console.log("Request Payload:", requestPayload);

                // Axios POST request to the backend API
                axios
                    .post("http://127.0.0.1:5002/LLM", requestPayload) // Updated endpoint
                    .then(apiResponse => {
                        console.log("API Response:", apiResponse.data);

                        // Navigate to the results page with the data
                        navigateToPage("/LLMResult", { state: { results: apiResponse.data } }); // Updated navigation state
                    })
                    .catch(apiError => {
                        console.error("Error:", apiError.response || apiError.message);
                        alert("An error occurred while processing the query. Please try again.");
                    });
            })
            .catch(validationError => {
                console.log("Validation Failed:", validationError);
            });
    };

    const handleGoBack = () => {
        console.log("Back button clicked");
        window.history.back();
    };

    return (
        <ConfigProvider
            theme={{
                algorithm: theme.darkAlgorithm,
                token: {
                    colorBgContainer: "#030712",
                    colorText: "#f3f4f6",
                    colorBorder: "#374151",
                    colorPrimaryHover: "#3b82f6",
                },
            }}
        >
            <div className="min-h-screen flex flex-col items-center justify-between bg-gray-950">
                {/* Header */}
                <header className="w-full py-4 bg-gray-800 border-b border-gray-700 shadow-lg flex items-center">
                    <Button
                        type="text"
                        icon={<ArrowLeftOutlined className="text-gray-100" />}
                        className="text-gray-100 hover:text-blue-500"
                        onClick={handleGoBack}
                    >
                        Back
                    </Button>
                    <h1 className="text-center text-white text-2xl tracking-wide flex-grow">
                        Welcome to LLM Assistant
                    </h1>
                </header>

                {/* Form Section */}
                <main className="w-full flex flex-col items-center mt-12">
                    <div className="bg-gray-800 rounded-lg shadow-lg w-4/5 max-w-3xl p-8 border border-gray-700">
                        <h2 className="text-xl font-semibold text-gray-100 mb-6">
                            Enter Your Query
                        </h2>
                        <Form form={formInstance} layout="vertical" className="grid grid-cols-1 gap-6">
                            {/* Query Field */}
                            <Form.Item
                                label={<span className="text-gray-100">Query:</span>}
                                name="query"
                            >
                                <Input
                                    placeholder="Enter your query"
                                    className="bg-gray-950 text-gray-100 border-gray-700"
                                />
                            </Form.Item>
                        </Form>
                        <div className="flex justify-end mt-6">
                            <Button
                                type="primary"
                                className="bg-gray-950 border-t border-gray-700 shadow-lg text-white hover:bg-blue-700 focus:bg-blue-900"
                                onClick={handleFormSubmit}
                            >
                                Submit
                            </Button>
                        </div>
                    </div>
                </main>

                {/* Footer */}
                <footer className="w-full py-4 bg-gray-800 border-t border-gray-700 shadow-lg text-gray-400 flex justify-between px-6 text-sm">
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

export default LLM;
