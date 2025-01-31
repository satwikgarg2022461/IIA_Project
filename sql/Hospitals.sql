PGDMP      !            
    |         	   Hospitals    17.0    17.0 n    j           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            k           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            l           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            m           1262    16387 	   Hospitals    DATABASE     �   CREATE DATABASE "Hospitals" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
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
       public               postgres    false    226            n           0    0    appointment_a_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.appointment_a_id_seq OWNED BY public.appointment.a_id;
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
       public               postgres    false    230            o           0    0    billing_b_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.billing_b_id_seq OWNED BY public.billing.b_id;
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
       public               postgres    false    222            p           0    0    doctor_d_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.doctor_d_id_seq OWNED BY public.doctor.d_id;
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
       public               postgres    false    218            q           0    0    hospital_details_h_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.hospital_details_h_id_seq OWNED BY public.hospital_details.h_id;
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
       public               postgres    false    232            r           0    0    insurance_i_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.insurance_i_id_seq OWNED BY public.insurance.i_id;
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
       public               postgres    false    236            s           0    0    medical_equipment_e_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.medical_equipment_e_id_seq OWNED BY public.medical_equipment.e_id;
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
       public               postgres    false    224            t           0    0    patient_p_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.patient_p_id_seq OWNED BY public.patient.p_id;
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
       public               postgres    false    234            u           0    0    room_r_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.room_r_id_seq OWNED BY public.room.r_id;
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
       public               postgres    false    220            v           0    0    speciality_s_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.speciality_s_id_seq OWNED BY public.speciality.s_id;
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
       public               postgres    false    238            w           0    0    staff_s_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.staff_s_id_seq OWNED BY public.staff.s_id;
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
       public               postgres    false    242            x           0    0    test_result_r_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.test_result_r_id_seq OWNED BY public.test_result.r_id;
          public               postgres    false    241            �            1259    16573    test_t_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_t_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.test_t_id_seq;
       public               postgres    false    240            y           0    0    test_t_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.test_t_id_seq OWNED BY public.test.t_id;
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
       public               postgres    false    228            z           0    0    treatment_record_t_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.treatment_record_t_id_seq OWNED BY public.treatment_record.t_id;
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
       public               postgres    false    227    228    228            W          0    16468    appointment 
   TABLE DATA                 public               postgres    false    226   p�       [          0    16506    billing 
   TABLE DATA                 public               postgres    false    230   ��       S          0    16440    doctor 
   TABLE DATA                 public               postgres    false    222   s�       O          0    16422    hospital_details 
   TABLE DATA                 public               postgres    false    218   �       ]          0    16528 	   insurance 
   TABLE DATA                 public               postgres    false    232   ��       a          0    16550    medical_equipment 
   TABLE DATA                 public               postgres    false    236   Ȉ       U          0    16459    patient 
   TABLE DATA                 public               postgres    false    224   �       _          0    16538    room 
   TABLE DATA                 public               postgres    false    234   2�       Q          0    16431 
   speciality 
   TABLE DATA                 public               postgres    false    220   �       c          0    16562    staff 
   TABLE DATA                 public               postgres    false    238   ��       e          0    16574    test 
   TABLE DATA                 public               postgres    false    240   �       g          0    16583    test_result 
   TABLE DATA                 public               postgres    false    242   :�       Y          0    16487    treatment_record 
   TABLE DATA                 public               postgres    false    228   �       {           0    0    appointment_a_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.appointment_a_id_seq', 3, true);
          public               postgres    false    225            |           0    0    billing_b_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.billing_b_id_seq', 3, true);
          public               postgres    false    229            }           0    0    doctor_d_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.doctor_d_id_seq', 3, true);
          public               postgres    false    221            ~           0    0    hospital_details_h_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.hospital_details_h_id_seq', 3, true);
          public               postgres    false    217                       0    0    insurance_i_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.insurance_i_id_seq', 3, true);
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
       public               postgres    false    4761    222    226            �           2606    16476 '   appointment appointment_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 Q   ALTER TABLE ONLY public.appointment DROP CONSTRAINT appointment_patient_id_fkey;
       public               postgres    false    226    4763    224            �           2606    16522 #   billing billing_appointment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointment(a_id);
 M   ALTER TABLE ONLY public.billing DROP CONSTRAINT billing_appointment_id_fkey;
       public               postgres    false    230    226    4765            �           2606    16517    billing billing_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctor(d_id);
 H   ALTER TABLE ONLY public.billing DROP CONSTRAINT billing_doctor_id_fkey;
       public               postgres    false    222    4761    230            �           2606    16512    billing billing_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 I   ALTER TABLE ONLY public.billing DROP CONSTRAINT billing_patient_id_fkey;
       public               postgres    false    230    224    4763            �           2606    16453    doctor doctor_h_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 A   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_h_id_fkey;
       public               postgres    false    222    4757    218            �           2606    16448    doctor doctor_s_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_s_id_fkey FOREIGN KEY (s_id) REFERENCES public.speciality(s_id);
 A   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_s_id_fkey;
       public               postgres    false    220    222    4759            �           2606    16556 -   medical_equipment medical_equipment_h_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medical_equipment
    ADD CONSTRAINT medical_equipment_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 W   ALTER TABLE ONLY public.medical_equipment DROP CONSTRAINT medical_equipment_h_id_fkey;
       public               postgres    false    218    4757    236            �           2606    16544    room room_h_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 =   ALTER TABLE ONLY public.room DROP CONSTRAINT room_h_id_fkey;
       public               postgres    false    4757    218    234            �           2606    16568    staff staff_h_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 ?   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_h_id_fkey;
       public               postgres    false    218    238    4757            �           2606    16601 &   test_result test_result_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT test_result_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctor(d_id);
 P   ALTER TABLE ONLY public.test_result DROP CONSTRAINT test_result_doctor_id_fkey;
       public               postgres    false    222    4761    242            �           2606    16591 '   test_result test_result_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT test_result_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 Q   ALTER TABLE ONLY public.test_result DROP CONSTRAINT test_result_patient_id_fkey;
       public               postgres    false    4763    224    242            �           2606    16596 $   test_result test_result_test_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT test_result_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.test(t_id);
 N   ALTER TABLE ONLY public.test_result DROP CONSTRAINT test_result_test_id_fkey;
       public               postgres    false    242    4779    240            �           2606    16500 0   treatment_record treatment_record_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.treatment_record
    ADD CONSTRAINT treatment_record_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctor(d_id);
 Z   ALTER TABLE ONLY public.treatment_record DROP CONSTRAINT treatment_record_doctor_id_fkey;
       public               postgres    false    4761    228    222            �           2606    16495 1   treatment_record treatment_record_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.treatment_record
    ADD CONSTRAINT treatment_record_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 [   ALTER TABLE ONLY public.treatment_record DROP CONSTRAINT treatment_record_patient_id_fkey;
       public               postgres    false    4763    228    224            W     x�͏1O�0������J)JR`B��H��ڔ�JlKX8>+>����	R`��7����*v��XS���V�����^�e{V"ے
s�9�0�/�gђ�NH��8jɻ�:4)$�V�t�?m���S��(��r��!�����,���g)��"�zRFB`��ۈ�XA͠��n_������b�7I�ǊE
Sf�"��g?(�Pk|[{��)�����iDv����?+oR�2+oF�|V��[-�SY{p�%�]܏����z)���E8I> ���x      [   �   x�͐Ak�0�������No;���ņ5�u8�Y�m���$��(��=�'�'�.����5�ܴh7�-�OX5�$C���EK���I)b�n�.�@cĐg0��<L�_s��t�n�O��V[7U�o8gP
.v|;��d�M���!�5�+נ�:�徆gJ�/R��7��M�;����P��_$� ���C�M�����_"�      S   j  x�Ւ]O�0����n��e#�ȇ�lF�\������ݦ��mÍ���4o��6�OF����(��l���N&�ZHhg;���I�6����M�Gi�2*Ӑ��d�Ī��!�hJj*�j=�()�T]R�9fS)�jXmzv��LV�wh�l��ҁ�s���-���~���:�*�T���%C'�"=S����	+�QY�5vu���Ԇ1)�~���]�q����h�
g	�c��dF�7����Ά�D~M��ߎ��(йP�y=�+K�)k�a���9L�H�UJ�nH��)Kci��,�ϖ�F	S)>.����׹���kt�o�c�"c\S��]4篴E5r�$yF����V�#J�      O   �  x�Ւ�N�0��}��$S%i���
?�TD
��u��µ#�mT���p��噵ǻ������b]B���F�2�T�Zʅ����IwH�q{$@�F�1�VI��~�AM w��7�[w�;�jj�ܺ�p�V/�w���E�bS��SxZ��+8�	3�,?z:����~��8��*�e'gi��9{�5�/j�;��e�����}�߇��n2J	�i��4:����,nVy����r�̋��A�'�%n�[�(�
�G��a�aE%�h*7Lyc��CI_aq� �4 t���LIK��o}�!�����{��b Ꚛ�����{p{iZ.�H�m!CiQ�!W��BnQ���b:s����8
D�yݢjn>�ڐ�����CƩ�o��S�fE����":�      ]   "  x�͑�j�0��y��%אŎK/Y�&�`���5��8�Zl���LB=��4�G3
�d��B�14:㌺��Z��"�ؑ�T�Dh])Bձ�e�����t K¸f�)�P���|���6��ā�k��̐�Cs�<�a2��mmN�Ce�˴ef0�S.�K��νK��8�8�M��M
�1Dq���� �ɩ�m����+����������EAN�m&u��B-�=����.��3�ہ��D\�1X����#$�@�	k��mV���d�[��aA���n0����0      a     x�͑�j�@��>��L`Qz�X�,$
Ѵ��dpa����}�6�J��0����_fEz(Afe�t2Z�Z��BS�y�}KlaA��4���%�	�j{0Z��(�E͖YQU�u?�����;�,Bn��`�+�Q5���q7��6x2s��ua��9��.I5�t+	yI�=�dR�SY^ne����?�D3�AB������f�G=�,�Bn�%4�Ig����J�~4v���������8���ˬ�F�@1���4���y�Ѿ�      U   >  x�͑KS�0���w�v�Ǹ��V���X�%��2򚔪��&�,�­n2�L�I���v��A�d)􇢮�ѳ��v�Y�W�-kP���w/yQ�a��+�%
x��y{h
�aU�+K����(d��srO��q���`���Y��b*=	|���N�rk�PJubَ�Lō���5~�����]��l���|�a�Q��sH��d����)$iv'7W����-9�+ T'������:!�e*w72��*]t����Kv�:p_��;�=G>ȿd��]�x`�����V���Q#^R{~ �L�R�%ۡ�/ԓ�����      _   �   x����
�@�O17�X��)�lAv���2�P��j�۷��t�`��N#�>� d����V�s�uW��R7.��.�m�Vd�e|��`q��͙��'S6����f!;~�C�FF72��	M�:�Q�X�dK���� ��D�u.�V
�*6BfO��1��G<r.�\tu=��5��.� �y�X[��8���/D�{���      Q   �   x���1k�0��ݿ�$`��t�Tܴ�4nWs���l�l𿯲:u*��ox�>�P�10N�v�F���e�ujٕ0`O%8J6�(�p��6i��~m����~8����U��q�Ậ�:F\|fJ�<H$��ɟ}Um�jFCm��I�<Ц9*��P�?��2N������iIB������J�Q"�t#�{���b��v�Њ�����      c     x�őMO�0����u�Bԯ����TZ��MI�M��մO2i'�8!$�~-�?vN�����V�s��ۉu,�A��9+6pF�.�B+~P�Ps��L�����
�9-��v��-a#p>1�a�y���7|��V�N�'�\�q�x��|���Fh;ʉ��у���JJ�(�Q���º���|]�� ZT�9}��?�I�����;��ʯV�F(�H�.4i�e^·k��ƣ����?��n��oBN���X~�!d���:>z��ɢ�P��g��      e     x�őAK�0���߭ԑNwѓvS������5_K�MJ������!���ϓȼڕ5ȼ.`���iV��`A��j�4�f2#gh�'�a�S����ۉ�Kx�߿�*X�	ę�	�wNC�fK1￠�3WA���	-����,�<��!�ɍX	���~�l�����G��"����2�a[@^��2����֌�~U�S`����>��߃��x?���T�ιP��_�(%T��g��L�̷��:e�l~qIA�;�-E�F�2      g   �   x�͐=�0����w�B�ZݜD�$���������VhW'��;�{8.n�k
.R��ͬɗ�==���%����"�+�0�CQ�T��W(��EO�Z?�cw�o��F�8�7�h�v��]�l��l�&]�sH��Ʌ�S$�L�\����q�02ǽg�TN��0�~�+���02��?�ʪ�����u�7:i��      Y   '  x�Ց�k�0���+�
ٰu>���cj
Z�Z��a1)I���Ċ�{�����7�}���r[@J�ڮ��~t�;�r��ZCW
N�eN�j����6}���P�l�$X��֛�ڈ�	������ZJ;�#x�e���1�^Q2N�ƱW���E�PY����Yxf�|j� B���3�:7Z	?#TRk~��v���9]e鼀E4/�)}}�EB��EZV�������'
�4d�#��W�k��(�?�0!���aVZ�.[���p<ssA�t�e��j��O_o{�n     