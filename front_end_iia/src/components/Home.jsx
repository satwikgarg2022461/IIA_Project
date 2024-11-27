import { Card, ConfigProvider, theme } from "antd";
import { useNavigate } from "react-router-dom"; // Import useNavigate
import DoctorsImage from "../assets/doctor.jpg";
import HospitalsImage from "../assets/hospital.jpg";
import TestsImage from "../assets/test.jpg";

const Home = () => {
    const navigate = useNavigate(); // Initialize navigate function

    // Function to handle card clicks and navigate to specific route
    const handleCardClick = (route) => {
        navigate(route);
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
            <main className="flex flex-col items-center justify-between min-h-screen bg-gray-950">
                {/* Top Header */}
                <header className="w-full py-4 bg-gray-800 border-b border-gray-700 shadow-lg">
                    <h1 className="text-center text-white text-2xl tracking-wide">
                        Welcome to Health Compass
                    </h1>
                </header>

                {/* Main Content */}
                <div className="bg-gray-800 border border-gray-700 shadow-2xl rounded-lg p-8 w-4/5 max-w-3xl flex flex-col items-center">
                    <h2 className="text-xl text-gray-100 font-semibold mb-6">
                        What would you like to search?
                    </h2>
                    <div className="flex justify-around w-full gap-8">
                        {/* Doctors */}
                        <div className="flex flex-col items-center group w-64 h-72">
                            <Card
                                hoverable
                                className="w-full h-full shadow-lg"
                                cover={
                                    <img
                                        src={DoctorsImage}
                                        alt="Doctors"
                                        className="h-40 object-cover"
                                    />
                                }
                                onClick={() => handleCardClick("/doctors")} // Handle click to navigate
                            >
                                <Card.Meta title="Doctors" description="Look for a doctor that suits your health." />
                            </Card>
                        </div>
                        {/* Hospitals */}
                        <div className="flex flex-col items-center group w-64 h-72">
                            <Card
                                hoverable
                                className="w-full h-full shadow-lg"
                                cover={
                                    <img
                                        src={HospitalsImage}
                                        alt="Hospitals"
                                        className="h-40 object-cover"
                                    />
                                }
                                onClick={() => handleCardClick("/hospitals")} // Handle click to navigate
                            >
                                <Card.Meta title="Hospitals" description="Find any hospital with ease and no hassles." />
                            </Card>
                        </div>
                        {/* Tests */}
                        <div className="flex flex-col items-center group w-64 h-72">
                            <Card
                                hoverable
                                className="w-full h-full shadow-lg"
                                cover={
                                    <img
                                        src={TestsImage}
                                        alt="Tests"
                                        className="h-40 object-cover"
                                    />
                                }
                                onClick={() => handleCardClick("/tests")} // Handle click to navigate
                            >
                                <Card.Meta title="Tests" description="Get your tests done with ease. and no Hassles" />
                            </Card>
                        </div>
                    </div>
                </div>

                {/* Footer */}
                <footer className="w-full bg-gray-800 border-t border-gray-700 py-2 flex justify-between px-6 text-gray-400 text-sm shadow-lg">
                    <span className="hover:text-blue-500 transition duration-300 cursor-pointer">
                        Terms & Conditions
                    </span>
                    <span className="hover:text-green-500 transition duration-300 cursor-pointer">
                        Help/Contact
                    </span>
                </footer>
            </main>
        </ConfigProvider>
    );
};

export default Home;
