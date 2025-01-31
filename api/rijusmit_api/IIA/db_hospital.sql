PGDMP      ;            
    |         	   Hospitals    17.0    17.0 n    w           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            x           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            y           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            z           1262    16387 	   Hospitals    DATABASE     �   CREATE DATABASE "Hospitals" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "Hospitals";
                     postgres    false            �            1259    16468    appointment    TABLE       CREATE TABLE public.appointment (
    a_id integer NOT NULL,
    patient_id integer,
    doctor_id integer,
    appointment_date date NOT NULL,
    appointment_time time without time zone NOT NULL,
    status character varying(20),
    reason text,
    notes text
);
    DROP TABLE public.appointment;
       public         heap r       postgres    false            �            1259    16467    appointment_a_id_seq    SEQUENCE     �   CREATE SEQUENCE public.appointment_a_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.appointment_a_id_seq;
       public               postgres    false    226            {           0    0    appointment_a_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.appointment_a_id_seq OWNED BY public.appointment.a_id;
          public               postgres    false    225            �            1259    16506    billing    TABLE       CREATE TABLE public.billing (
    b_id integer NOT NULL,
    patient_id integer,
    doctor_id integer,
    appointment_id integer,
    amount numeric(10,2) NOT NULL,
    date date NOT NULL,
    status character varying(20),
    payment_method character varying(20)
);
    DROP TABLE public.billing;
       public         heap r       postgres    false            �            1259    16505    billing_b_id_seq    SEQUENCE     �   CREATE SEQUENCE public.billing_b_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.billing_b_id_seq;
       public               postgres    false    230            |           0    0    billing_b_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.billing_b_id_seq OWNED BY public.billing.b_id;
          public               postgres    false    229            �            1259    16440    doctor    TABLE     n  CREATE TABLE public.doctor (
    d_id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone_number character varying(20),
    email character varying(100),
    s_id integer,
    h_id integer,
    address text,
    qualification character varying(100),
    experience integer,
    schedule character varying(50),
    consultation_fee numeric(10,2)
);
    DROP TABLE public.doctor;
       public         heap r       postgres    false            �            1259    16439    doctor_d_id_seq    SEQUENCE     �   CREATE SEQUENCE public.doctor_d_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.doctor_d_id_seq;
       public               postgres    false    222            }           0    0    doctor_d_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.doctor_d_id_seq OWNED BY public.doctor.d_id;
          public               postgres    false    221            �            1259    16422    hospital_details    TABLE     �  CREATE TABLE public.hospital_details (
    h_id integer NOT NULL,
    name character varying(100) NOT NULL,
    city character varying(50) NOT NULL,
    address character varying(500) NOT NULL,
    phone_number character varying(20),
    email character varying(100),
    website character varying(100),
    type character varying(50),
    rating double precision,
    number_of_beds integer,
    established_year integer
);
 $   DROP TABLE public.hospital_details;
       public         heap r       postgres    false            �            1259    16421    hospital_details_h_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hospital_details_h_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.hospital_details_h_id_seq;
       public               postgres    false    218            ~           0    0    hospital_details_h_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.hospital_details_h_id_seq OWNED BY public.hospital_details.h_id;
          public               postgres    false    217            �            1259    16528 	   insurance    TABLE       CREATE TABLE public.insurance (
    i_id integer NOT NULL,
    name character varying(100) NOT NULL,
    contact_number character varying(20),
    address text,
    email character varying(100),
    website character varying(100),
    accepted boolean DEFAULT false
);
    DROP TABLE public.insurance;
       public         heap r       postgres    false            �            1259    16527    insurance_i_id_seq    SEQUENCE     �   CREATE SEQUENCE public.insurance_i_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.insurance_i_id_seq;
       public               postgres    false    232                       0    0    insurance_i_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.insurance_i_id_seq OWNED BY public.insurance.i_id;
          public               postgres    false    231            �            1259    16550    medical_equipment    TABLE        CREATE TABLE public.medical_equipment (
    e_id integer NOT NULL,
    h_id integer,
    name character varying(100) NOT NULL,
    quantity integer NOT NULL,
    status character varying(20),
    maintenance_date date,
    vendor character varying(100)
);
 %   DROP TABLE public.medical_equipment;
       public         heap r       postgres    false            �            1259    16549    medical_equipment_e_id_seq    SEQUENCE     �   CREATE SEQUENCE public.medical_equipment_e_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.medical_equipment_e_id_seq;
       public               postgres    false    236            �           0    0    medical_equipment_e_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.medical_equipment_e_id_seq OWNED BY public.medical_equipment.e_id;
          public               postgres    false    235            �            1259    16459    patient    TABLE     !  CREATE TABLE public.patient (
    p_id integer NOT NULL,
    name character varying(100) NOT NULL,
    date_of_birth date,
    gender character(1),
    contact_number character varying(20),
    email character varying(100),
    address text,
    emergency_contact character varying(20)
);
    DROP TABLE public.patient;
       public         heap r       postgres    false            �            1259    16458    patient_p_id_seq    SEQUENCE     �   CREATE SEQUENCE public.patient_p_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.patient_p_id_seq;
       public               postgres    false    224            �           0    0    patient_p_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.patient_p_id_seq OWNED BY public.patient.p_id;
          public               postgres    false    223            �            1259    16538    room    TABLE     �   CREATE TABLE public.room (
    r_id integer NOT NULL,
    h_id integer,
    room_number character varying(20) NOT NULL,
    room_type character varying(50),
    status character varying(20),
    charges_per_day numeric(10,2)
);
    DROP TABLE public.room;
       public         heap r       postgres    false            �            1259    16537    room_r_id_seq    SEQUENCE     �   CREATE SEQUENCE public.room_r_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.room_r_id_seq;
       public               postgres    false    234            �           0    0    room_r_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.room_r_id_seq OWNED BY public.room.r_id;
          public               postgres    false    233            �            1259    16431 
   speciality    TABLE     �   CREATE TABLE public.speciality (
    s_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    avg_consultation_fee numeric(10,2)
);
    DROP TABLE public.speciality;
       public         heap r       postgres    false            �            1259    16430    speciality_s_id_seq    SEQUENCE     �   CREATE SEQUENCE public.speciality_s_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.speciality_s_id_seq;
       public               postgres    false    220            �           0    0    speciality_s_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.speciality_s_id_seq OWNED BY public.speciality.s_id;
          public               postgres    false    219            �            1259    16562    staff    TABLE       CREATE TABLE public.staff (
    s_id integer NOT NULL,
    h_id integer,
    name character varying(100) NOT NULL,
    role character varying(50),
    phone_number character varying(20),
    email character varying(100),
    shift character varying(20),
    salary numeric(10,2)
);
    DROP TABLE public.staff;
       public         heap r       postgres    false            �            1259    16561    staff_s_id_seq    SEQUENCE     �   CREATE SEQUENCE public.staff_s_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.staff_s_id_seq;
       public               postgres    false    238            �           0    0    staff_s_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.staff_s_id_seq OWNED BY public.staff.s_id;
          public               postgres    false    237            �            1259    16574    test    TABLE     �   CREATE TABLE public.test (
    t_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    cost numeric(10,2),
    category character varying(50),
    result_timeframe interval
);
    DROP TABLE public.test;
       public         heap r       postgres    false            �            1259    16583    test_result    TABLE     �   CREATE TABLE public.test_result (
    r_id integer NOT NULL,
    patient_id integer,
    test_id integer,
    doctor_id integer,
    test_date date NOT NULL,
    result text,
    status character varying(20)
);
    DROP TABLE public.test_result;
       public         heap r       postgres    false            �            1259    16582    test_result_r_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_result_r_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.test_result_r_id_seq;
       public               postgres    false    242            �           0    0    test_result_r_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.test_result_r_id_seq OWNED BY public.test_result.r_id;
          public               postgres    false    241            �            1259    16573    test_t_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_t_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.test_t_id_seq;
       public               postgres    false    240            �           0    0    test_t_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.test_t_id_seq OWNED BY public.test.t_id;
          public               postgres    false    239            �            1259    16487    treatment_record    TABLE     �   CREATE TABLE public.treatment_record (
    t_id integer NOT NULL,
    patient_id integer,
    doctor_id integer,
    date_of_treatment date NOT NULL,
    diagnosis text,
    prescription text,
    follow_up date,
    notes text
);
 $   DROP TABLE public.treatment_record;
       public         heap r       postgres    false            �            1259    16486    treatment_record_t_id_seq    SEQUENCE     �   CREATE SEQUENCE public.treatment_record_t_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.treatment_record_t_id_seq;
       public               postgres    false    228            �           0    0    treatment_record_t_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.treatment_record_t_id_seq OWNED BY public.treatment_record.t_id;
          public               postgres    false    227            �           2604    16471    appointment a_id    DEFAULT     t   ALTER TABLE ONLY public.appointment ALTER COLUMN a_id SET DEFAULT nextval('public.appointment_a_id_seq'::regclass);
 ?   ALTER TABLE public.appointment ALTER COLUMN a_id DROP DEFAULT;
       public               postgres    false    225    226    226            �           2604    16509    billing b_id    DEFAULT     l   ALTER TABLE ONLY public.billing ALTER COLUMN b_id SET DEFAULT nextval('public.billing_b_id_seq'::regclass);
 ;   ALTER TABLE public.billing ALTER COLUMN b_id DROP DEFAULT;
       public               postgres    false    229    230    230            �           2604    16443    doctor d_id    DEFAULT     j   ALTER TABLE ONLY public.doctor ALTER COLUMN d_id SET DEFAULT nextval('public.doctor_d_id_seq'::regclass);
 :   ALTER TABLE public.doctor ALTER COLUMN d_id DROP DEFAULT;
       public               postgres    false    221    222    222            �           2604    16425    hospital_details h_id    DEFAULT     ~   ALTER TABLE ONLY public.hospital_details ALTER COLUMN h_id SET DEFAULT nextval('public.hospital_details_h_id_seq'::regclass);
 D   ALTER TABLE public.hospital_details ALTER COLUMN h_id DROP DEFAULT;
       public               postgres    false    217    218    218            �           2604    16531    insurance i_id    DEFAULT     p   ALTER TABLE ONLY public.insurance ALTER COLUMN i_id SET DEFAULT nextval('public.insurance_i_id_seq'::regclass);
 =   ALTER TABLE public.insurance ALTER COLUMN i_id DROP DEFAULT;
       public               postgres    false    232    231    232            �           2604    16553    medical_equipment e_id    DEFAULT     �   ALTER TABLE ONLY public.medical_equipment ALTER COLUMN e_id SET DEFAULT nextval('public.medical_equipment_e_id_seq'::regclass);
 E   ALTER TABLE public.medical_equipment ALTER COLUMN e_id DROP DEFAULT;
       public               postgres    false    236    235    236            �           2604    16462    patient p_id    DEFAULT     l   ALTER TABLE ONLY public.patient ALTER COLUMN p_id SET DEFAULT nextval('public.patient_p_id_seq'::regclass);
 ;   ALTER TABLE public.patient ALTER COLUMN p_id DROP DEFAULT;
       public               postgres    false    224    223    224            �           2604    16541 	   room r_id    DEFAULT     f   ALTER TABLE ONLY public.room ALTER COLUMN r_id SET DEFAULT nextval('public.room_r_id_seq'::regclass);
 8   ALTER TABLE public.room ALTER COLUMN r_id DROP DEFAULT;
       public               postgres    false    233    234    234            �           2604    16434    speciality s_id    DEFAULT     r   ALTER TABLE ONLY public.speciality ALTER COLUMN s_id SET DEFAULT nextval('public.speciality_s_id_seq'::regclass);
 >   ALTER TABLE public.speciality ALTER COLUMN s_id DROP DEFAULT;
       public               postgres    false    220    219    220            �           2604    16565 
   staff s_id    DEFAULT     h   ALTER TABLE ONLY public.staff ALTER COLUMN s_id SET DEFAULT nextval('public.staff_s_id_seq'::regclass);
 9   ALTER TABLE public.staff ALTER COLUMN s_id DROP DEFAULT;
       public               postgres    false    237    238    238            �           2604    16577 	   test t_id    DEFAULT     f   ALTER TABLE ONLY public.test ALTER COLUMN t_id SET DEFAULT nextval('public.test_t_id_seq'::regclass);
 8   ALTER TABLE public.test ALTER COLUMN t_id DROP DEFAULT;
       public               postgres    false    239    240    240            �           2604    16586    test_result r_id    DEFAULT     t   ALTER TABLE ONLY public.test_result ALTER COLUMN r_id SET DEFAULT nextval('public.test_result_r_id_seq'::regclass);
 ?   ALTER TABLE public.test_result ALTER COLUMN r_id DROP DEFAULT;
       public               postgres    false    242    241    242            �           2604    16490    treatment_record t_id    DEFAULT     ~   ALTER TABLE ONLY public.treatment_record ALTER COLUMN t_id SET DEFAULT nextval('public.treatment_record_t_id_seq'::regclass);
 D   ALTER TABLE public.treatment_record ALTER COLUMN t_id DROP DEFAULT;
       public               postgres    false    227    228    228            d          0    16468    appointment 
   TABLE DATA           }   COPY public.appointment (a_id, patient_id, doctor_id, appointment_date, appointment_time, status, reason, notes) FROM stdin;
    public               postgres    false    226   �       h          0    16506    billing 
   TABLE DATA           t   COPY public.billing (b_id, patient_id, doctor_id, appointment_id, amount, date, status, payment_method) FROM stdin;
    public               postgres    false    230   ��       `          0    16440    doctor 
   TABLE DATA           �   COPY public.doctor (d_id, name, phone_number, email, s_id, h_id, address, qualification, experience, schedule, consultation_fee) FROM stdin;
    public               postgres    false    222   �       \          0    16422    hospital_details 
   TABLE DATA           �   COPY public.hospital_details (h_id, name, city, address, phone_number, email, website, type, rating, number_of_beds, established_year) FROM stdin;
    public               postgres    false    218   �       j          0    16528 	   insurance 
   TABLE DATA           b   COPY public.insurance (i_id, name, contact_number, address, email, website, accepted) FROM stdin;
    public               postgres    false    232   �       n          0    16550    medical_equipment 
   TABLE DATA           i   COPY public.medical_equipment (e_id, h_id, name, quantity, status, maintenance_date, vendor) FROM stdin;
    public               postgres    false    236   ҋ       b          0    16459    patient 
   TABLE DATA           w   COPY public.patient (p_id, name, date_of_birth, gender, contact_number, email, address, emergency_contact) FROM stdin;
    public               postgres    false    224   t�       l          0    16538    room 
   TABLE DATA           [   COPY public.room (r_id, h_id, room_number, room_type, status, charges_per_day) FROM stdin;
    public               postgres    false    234   :�       ^          0    16431 
   speciality 
   TABLE DATA           S   COPY public.speciality (s_id, name, description, avg_consultation_fee) FROM stdin;
    public               postgres    false    220   ��       p          0    16562    staff 
   TABLE DATA           [   COPY public.staff (s_id, h_id, name, role, phone_number, email, shift, salary) FROM stdin;
    public               postgres    false    238   )�       r          0    16574    test 
   TABLE DATA           Y   COPY public.test (t_id, name, description, cost, category, result_timeframe) FROM stdin;
    public               postgres    false    240   ׎       t          0    16583    test_result 
   TABLE DATA           f   COPY public.test_result (r_id, patient_id, test_id, doctor_id, test_date, result, status) FROM stdin;
    public               postgres    false    242   ��       f          0    16487    treatment_record 
   TABLE DATA           �   COPY public.treatment_record (t_id, patient_id, doctor_id, date_of_treatment, diagnosis, prescription, follow_up, notes) FROM stdin;
    public               postgres    false    228   ��       �           0    0    appointment_a_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.appointment_a_id_seq', 3, true);
          public               postgres    false    225            �           0    0    billing_b_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.billing_b_id_seq', 3, true);
          public               postgres    false    229            �           0    0    doctor_d_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.doctor_d_id_seq', 3, true);
          public               postgres    false    221            �           0    0    hospital_details_h_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.hospital_details_h_id_seq', 3, true);
          public               postgres    false    217            �           0    0    insurance_i_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.insurance_i_id_seq', 3, true);
          public               postgres    false    231            �           0    0    medical_equipment_e_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.medical_equipment_e_id_seq', 3, true);
          public               postgres    false    235            �           0    0    patient_p_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.patient_p_id_seq', 3, true);
          public               postgres    false    223            �           0    0    room_r_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.room_r_id_seq', 3, true);
          public               postgres    false    233            �           0    0    speciality_s_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.speciality_s_id_seq', 3, true);
          public               postgres    false    219            �           0    0    staff_s_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.staff_s_id_seq', 3, true);
          public               postgres    false    237            �           0    0    test_result_r_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.test_result_r_id_seq', 3, true);
          public               postgres    false    241            �           0    0    test_t_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.test_t_id_seq', 3, true);
          public               postgres    false    239            �           0    0    treatment_record_t_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.treatment_record_t_id_seq', 3, true);
          public               postgres    false    227            �           2606    16475    appointment appointment_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (a_id);
 F   ALTER TABLE ONLY public.appointment DROP CONSTRAINT appointment_pkey;
       public                 postgres    false    226            �           2606    16511    billing billing_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_pkey PRIMARY KEY (b_id);
 >   ALTER TABLE ONLY public.billing DROP CONSTRAINT billing_pkey;
       public                 postgres    false    230            �           2606    16447    doctor doctor_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (d_id);
 <   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_pkey;
       public                 postgres    false    222            �           2606    16429 &   hospital_details hospital_details_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.hospital_details
    ADD CONSTRAINT hospital_details_pkey PRIMARY KEY (h_id);
 P   ALTER TABLE ONLY public.hospital_details DROP CONSTRAINT hospital_details_pkey;
       public                 postgres    false    218            �           2606    16536    insurance insurance_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.insurance
    ADD CONSTRAINT insurance_pkey PRIMARY KEY (i_id);
 B   ALTER TABLE ONLY public.insurance DROP CONSTRAINT insurance_pkey;
       public                 postgres    false    232            �           2606    16555 (   medical_equipment medical_equipment_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.medical_equipment
    ADD CONSTRAINT medical_equipment_pkey PRIMARY KEY (e_id);
 R   ALTER TABLE ONLY public.medical_equipment DROP CONSTRAINT medical_equipment_pkey;
       public                 postgres    false    236            �           2606    16466    patient patient_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (p_id);
 >   ALTER TABLE ONLY public.patient DROP CONSTRAINT patient_pkey;
       public                 postgres    false    224            �           2606    16543    room room_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (r_id);
 8   ALTER TABLE ONLY public.room DROP CONSTRAINT room_pkey;
       public                 postgres    false    234            �           2606    16438    speciality speciality_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.speciality
    ADD CONSTRAINT speciality_pkey PRIMARY KEY (s_id);
 D   ALTER TABLE ONLY public.speciality DROP CONSTRAINT speciality_pkey;
       public                 postgres    false    220            �           2606    16567    staff staff_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (s_id);
 :   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_pkey;
       public                 postgres    false    238            �           2606    16581    test test_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (t_id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public                 postgres    false    240            �           2606    16590    test_result test_result_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT test_result_pkey PRIMARY KEY (r_id);
 F   ALTER TABLE ONLY public.test_result DROP CONSTRAINT test_result_pkey;
       public                 postgres    false    242            �           2606    16494 &   treatment_record treatment_record_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.treatment_record
    ADD CONSTRAINT treatment_record_pkey PRIMARY KEY (t_id);
 P   ALTER TABLE ONLY public.treatment_record DROP CONSTRAINT treatment_record_pkey;
       public                 postgres    false    228            �           2606    16481 &   appointment appointment_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctor(d_id);
 P   ALTER TABLE ONLY public.appointment DROP CONSTRAINT appointment_doctor_id_fkey;
       public               postgres    false    4774    222    226            �           2606    16476 '   appointment appointment_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 Q   ALTER TABLE ONLY public.appointment DROP CONSTRAINT appointment_patient_id_fkey;
       public               postgres    false    226    4776    224            �           2606    16522 #   billing billing_appointment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointment(a_id);
 M   ALTER TABLE ONLY public.billing DROP CONSTRAINT billing_appointment_id_fkey;
       public               postgres    false    230    226    4778            �           2606    16517    billing billing_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctor(d_id);
 H   ALTER TABLE ONLY public.billing DROP CONSTRAINT billing_doctor_id_fkey;
       public               postgres    false    222    4774    230            �           2606    16512    billing billing_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 I   ALTER TABLE ONLY public.billing DROP CONSTRAINT billing_patient_id_fkey;
       public               postgres    false    230    224    4776            �           2606    16453    doctor doctor_h_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 A   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_h_id_fkey;
       public               postgres    false    222    4770    218            �           2606    16448    doctor doctor_s_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_s_id_fkey FOREIGN KEY (s_id) REFERENCES public.speciality(s_id);
 A   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_s_id_fkey;
       public               postgres    false    220    222    4772            �           2606    16556 -   medical_equipment medical_equipment_h_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medical_equipment
    ADD CONSTRAINT medical_equipment_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 W   ALTER TABLE ONLY public.medical_equipment DROP CONSTRAINT medical_equipment_h_id_fkey;
       public               postgres    false    218    4770    236            �           2606    16544    room room_h_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 =   ALTER TABLE ONLY public.room DROP CONSTRAINT room_h_id_fkey;
       public               postgres    false    4770    218    234            �           2606    16568    staff staff_h_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 ?   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_h_id_fkey;
       public               postgres    false    218    238    4770            �           2606    16601 &   test_result test_result_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT test_result_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctor(d_id);
 P   ALTER TABLE ONLY public.test_result DROP CONSTRAINT test_result_doctor_id_fkey;
       public               postgres    false    222    4774    242            �           2606    16591 '   test_result test_result_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT test_result_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 Q   ALTER TABLE ONLY public.test_result DROP CONSTRAINT test_result_patient_id_fkey;
       public               postgres    false    4776    224    242            �           2606    16596 $   test_result test_result_test_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT test_result_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.test(t_id);
 N   ALTER TABLE ONLY public.test_result DROP CONSTRAINT test_result_test_id_fkey;
       public               postgres    false    242    4792    240            �           2606    16500 0   treatment_record treatment_record_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.treatment_record
    ADD CONSTRAINT treatment_record_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctor(d_id);
 Z   ALTER TABLE ONLY public.treatment_record DROP CONSTRAINT treatment_record_doctor_id_fkey;
       public               postgres    false    4774    228    222            �           2606    16495 1   treatment_record treatment_record_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.treatment_record
    ADD CONSTRAINT treatment_record_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 [   ALTER TABLE ONLY public.treatment_record DROP CONSTRAINT treatment_record_patient_id_fkey;
       public               postgres    false    4776    228    224            d   �   x�e��
B1��W��dsm�,E�m�ɂ�$�P�{Q�S�A��Vz=)���*��\�6ONܪ�$�an-��#	o��T➽��Ԓ���*�F@.��ʔ���I�0��f@���䩎�o�<C�
�i�[��@֙Ku�y%�xu�:�      h   T   x�]ʱ� ��{�,d㤱 	A�?�Bw峰3�l�!,�d��[KDh)���"	V~��S�V��Q�*���5$����G      `   �   x�UϽj�0����*��B?��lm0��
)d�$�`YFV���+KS��wy����g<�kAk]	�j���֭=ѯ��D��,�mRa���y|73�Ѓ�0��z��w�Vz��8g�2���Yݜݴ�X�-�F�պ�W2S�����TL(Q��ԑ�3��A�<���J�6�-���v;<�4ʹ������ҙ#]J�"�"��Ŋ���(WQ      \     x�m��j�0 �����d+qn�6�>B�B/���ET�X�M��ULȥ��vgqhL<�և�De�&����(�Y�m��BJ�H��}��Rw�ɵ��i��pw��FC�K��_W,�89|W��k\i�ÇA9m��P�%��#nF����vb+��E�c}�(�٠g�����n0��I��.!k�О\�#ܒ��Æ\��|��;�� �j�~���o{(8�SdБ��WE7nwpۓ6ʚ_ڧ�
�c2�̳,���{q      j   �   x�]���0F�ۧ�H�P�qPV�Z�OR[��B|{+&$���|''7�JyI�~����.�')�C��y˵+�0���l�ȑ0/��9� ${�H���+�$��R�ѓ��坤�I���h,��"�A^��$���ʳ���d�g��@k�J|�JM�5�
^����?i�#"�| #KP�      n   �   x�U�=
�0��S�)Mb� "�!�Utpy�x�1moo��ߏw��#�)D�������5Vi�Z���I�F0�ν<�H,�(3%ySv�W��!���UB�}􍰕��q�K�����v;n�1ˡ�ā�h�_��3      b   �   x�Uα� ���x�{H)���Z㤉�����؈ŠQ_Jtp���;	��� �ya�԰�5�����D�2Y��]o����J��1g�?2צ���e豝N�aJ��r)yY�6������%M�+܍a��̫t�)�\7D)��H�ߓiE�0υ'��ն��N.�*f�*m�Q0�>��C�      l   [   x�3�4�440�tO�K-J�QO,J�L,K��IL�IJ�pq����s(g~rriAfj
�1DΘ�9�2�KR�4A��qqq �&L      ^   t   x�M�1�0��9�O�R�X:���K��H�H�A��Y����Y4�V��D�eO���%>a�ʮ߰;M11����=�al�9�?��v�7Rײ͹��R=������B���,�      p   �   x�eλ
�0 F���S�i.�E�Tpq�i0Q��$R|{ۢ�8�85jlt��:Z쭱}�1�\��Z�5縍���.]̽/�AM����b�Q��V�{�Jq8Z�7^�YBJtc��)�:�_]��J�tur�X�)�Q�i��B����H�!Δ��Y?�      r   �   x�U���0E�ׯx? iQGqa`A�'}�&�^�{+��;��c��{��xB�X��G��d�Xк��}�6q��':|}a(t�5��;K��t�:M��84�@5R�|�*�$o1:���^��m6�uS�%W������0����b_2hiQ�L)�gE�      t   _   x�3�4C##]C ���/�M��L��-�I-IM�2�B�#N����ҢT��<��Դ�Ģ\$Ɯ�a4U!1)ltfIfj1��=... H$$�      f   �   x�e�M�0����s 4����q�l
�@cmI[L����11�,f�=xJ���y:��#�H6hg�"�;Ӌ�y��QIm�m �A嬎�ck�S8z
a���}`-[�~�S���K8�=61L��h�E&���jW3��BDi��+M��Ě=c��@�     