import { ConfigProvider, theme, Input, Button, Form } from "antd"; // Ant Design components
import { ArrowLeftOutlined } from "@ant-design/icons"; // Ant Design icon
import HospitalLogo from "../assets/hospital_svg.png";
import axios from "axios";
import {useNavigate} from "react-router-dom"; // Logo import

const Hospital = () => {
    const [form] = Form.useForm();
    const navigate = useNavigate();

    const handleSubmit = () => {
        form.validateFields()
            .then(values => {
                const {t_name, h_name} = values;

                // Check which fields are filled
                const filledFields = [];
                if (t_name) filledFields.push("t_name");
                if (h_name) filledFields.push("h_name");

                if (filledFields.length === 0) {
                    alert("Please fill at least one field.");
                    return;
                }


                // Construct the signal string in alphabetical order
                // const signal = filledFields.sort().join("_");
                const requestData = {t_name, h_name};

                console.log("Request Data:", requestData);

                // Axios POST request to the backend API
                axios
                    .post("http://127.0.0.1:5002/get-test-info", requestData)
                    .then(response => {
                        console.log("Response:", response.data);
                        // alert("Search results received. Check console for data.");
                        // Replace with your UI update logic
                        navigate("/tests-results", { state: { results: response.data } });
                    })
                    .catch(error => {
                        console.error("Error:", error.response || error.message);
                        alert("An error occurred while fetching the data. Please try again.");
                    });
            })
            .catch(errorInfo => {
                console.log("Validation Failed:", errorInfo);
            });
    }

    const handleBack = () => {
        console.log("Back button clicked");
        // Add your back navigation logic here, e.g., navigate to the previous page.
        window.history.back();
    };

    return (
        <ConfigProvider
            theme={{
                algorithm: theme.darkAlgorithm,
                token: {
                    colorBgContainer: "#030712", // Tailwind `gray-800`
                    colorText: "#f3f4f6", // Tailwind `gray-100`
                    colorBorder: "#374151", // Tailwind `gray-700`
                    colorPrimaryHover: "#3b82f6", // Blue hover
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
                        onClick={handleBack}
                    >
                        Back
                    </Button>
                    <h1 className="text-center text-white text-2xl tracking-wide flex-grow">
                        Welcome to Health Compass
                    </h1>
                </header>

                {/* Form Section */}
                <main className="w-full flex flex-col items-center mt-12">
                    <div className="bg-gray-800 rounded-lg shadow-lg w-4/5 max-w-3xl p-8 border border-gray-700">
                        <h2 className="text-xl font-semibold text-gray-100 mb-6">
                            Search for a Hospital
                        </h2>
                        <Form form={form} layout="vertical" className="grid grid-cols-2 gap-6">
                            {/* Name Field */}
                            <Form.Item
                                label={<span className="text-gray-100">Test Name:</span>}
                                name="t_name"
                            >
                                <Input
                                    placeholder="Enter test type"
                                    className="bg-gray-950 text-gray-100 border-gray-700"
                                />
                            </Form.Item>

                            <Form.Item
                                label={<span className="text-gray-100">Hospital name:</span>}
                                name="h_name"
                            >
                                <Input
                                    placeholder="Enter test type"
                                    className="bg-gray-950 text-gray-100 border-gray-700"
                                />
                            </Form.Item>


                        </Form>
                        <div className="flex justify-end mt-6">
                            <Button
                                type="primary"
                                className="bg-gray-950 border-t border-gray-700 shadow-lg text-white hover:bg-blue-700 focus:bg-blue-900"
                                onClick={handleSubmit}
                            >
                                Search
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

export default Hospital;
