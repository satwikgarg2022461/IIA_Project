PGDMP  )    :            
    |         	   hospitals    17.0    17.0 ]    y           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            z           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            {           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            |           1262    16389 	   hospitals    DATABASE     k   CREATE DATABASE hospitals WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE hospitals;
                     hospitals_owner    false            }           0    0    DATABASE hospitals    ACL     3   GRANT ALL ON DATABASE hospitals TO neon_superuser;
                        hospitals_owner    false    3452            �            1259    24576    appointment    TABLE       CREATE TABLE public.appointment (
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
       public         heap r       hospitals_owner    false            �            1259    24581    appointment_a_id_seq    SEQUENCE     �   CREATE SEQUENCE public.appointment_a_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.appointment_a_id_seq;
       public               hospitals_owner    false    217            ~           0    0    appointment_a_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.appointment_a_id_seq OWNED BY public.appointment.a_id;
          public               hospitals_owner    false    218            �            1259    24586    doctor    TABLE     n  CREATE TABLE public.doctor (
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
       public         heap r       hospitals_owner    false            �            1259    24591    doctor_d_id_seq    SEQUENCE     �   CREATE SEQUENCE public.doctor_d_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.doctor_d_id_seq;
       public               hospitals_owner    false    219                       0    0    doctor_d_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.doctor_d_id_seq OWNED BY public.doctor.d_id;
          public               hospitals_owner    false    220            �            1259    24592    hospital_details    TABLE     �  CREATE TABLE public.hospital_details (
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
       public         heap r       hospitals_owner    false            �            1259    24597    hospital_details_h_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hospital_details_h_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.hospital_details_h_id_seq;
       public               hospitals_owner    false    221            �           0    0    hospital_details_h_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.hospital_details_h_id_seq OWNED BY public.hospital_details.h_id;
          public               hospitals_owner    false    222            �            1259    24598 	   insurance    TABLE       CREATE TABLE public.insurance (
    i_id integer NOT NULL,
    name character varying(100) NOT NULL,
    contact_number character varying(20),
    address text,
    email character varying(100),
    website character varying(100),
    accepted boolean DEFAULT false
);
    DROP TABLE public.insurance;
       public         heap r       hospitals_owner    false            �            1259    24604    insurance_i_id_seq    SEQUENCE     �   CREATE SEQUENCE public.insurance_i_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.insurance_i_id_seq;
       public               hospitals_owner    false    223            �           0    0    insurance_i_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.insurance_i_id_seq OWNED BY public.insurance.i_id;
          public               hospitals_owner    false    224            �            1259    24605    medical_equipment    TABLE        CREATE TABLE public.medical_equipment (
    e_id integer NOT NULL,
    h_id integer,
    name character varying(100) NOT NULL,
    quantity integer NOT NULL,
    status character varying(20),
    maintenance_date date,
    vendor character varying(100)
);
 %   DROP TABLE public.medical_equipment;
       public         heap r       hospitals_owner    false            �            1259    24608    medical_equipment_e_id_seq    SEQUENCE     �   CREATE SEQUENCE public.medical_equipment_e_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.medical_equipment_e_id_seq;
       public               hospitals_owner    false    225            �           0    0    medical_equipment_e_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.medical_equipment_e_id_seq OWNED BY public.medical_equipment.e_id;
          public               hospitals_owner    false    226            �            1259    24609    patient    TABLE     !  CREATE TABLE public.patient (
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
       public         heap r       hospitals_owner    false            �            1259    24614    patient_p_id_seq    SEQUENCE     �   CREATE SEQUENCE public.patient_p_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.patient_p_id_seq;
       public               hospitals_owner    false    227            �           0    0    patient_p_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.patient_p_id_seq OWNED BY public.patient.p_id;
          public               hospitals_owner    false    228            �            1259    24615    room    TABLE     �   CREATE TABLE public.room (
    r_id integer NOT NULL,
    h_id integer,
    room_number character varying(20) NOT NULL,
    room_type character varying(50),
    status character varying(20),
    charges_per_day numeric(10,2)
);
    DROP TABLE public.room;
       public         heap r       hospitals_owner    false            �            1259    24618    room_r_id_seq    SEQUENCE     �   CREATE SEQUENCE public.room_r_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.room_r_id_seq;
       public               hospitals_owner    false    229            �           0    0    room_r_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.room_r_id_seq OWNED BY public.room.r_id;
          public               hospitals_owner    false    230            �            1259    24619 
   speciality    TABLE     �   CREATE TABLE public.speciality (
    s_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    avg_consultation_fee numeric(10,2)
);
    DROP TABLE public.speciality;
       public         heap r       hospitals_owner    false            �            1259    24624    speciality_s_id_seq    SEQUENCE     �   CREATE SEQUENCE public.speciality_s_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.speciality_s_id_seq;
       public               hospitals_owner    false    231            �           0    0    speciality_s_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.speciality_s_id_seq OWNED BY public.speciality.s_id;
          public               hospitals_owner    false    232            �            1259    24625    staff    TABLE       CREATE TABLE public.staff (
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
       public         heap r       hospitals_owner    false            �            1259    24628    staff_s_id_seq    SEQUENCE     �   CREATE SEQUENCE public.staff_s_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.staff_s_id_seq;
       public               hospitals_owner    false    233            �           0    0    staff_s_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.staff_s_id_seq OWNED BY public.staff.s_id;
          public               hospitals_owner    false    234            �            1259    24629    test    TABLE     �   CREATE TABLE public.test (
    t_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    cost numeric(10,2),
    category character varying(50),
    result_timeframe interval
);
    DROP TABLE public.test;
       public         heap r       hospitals_owner    false            �            1259    24640    test_t_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_t_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.test_t_id_seq;
       public               hospitals_owner    false    235            �           0    0    test_t_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.test_t_id_seq OWNED BY public.test.t_id;
          public               hospitals_owner    false    236            �            1259    24641    treatment_record    TABLE     �   CREATE TABLE public.treatment_record (
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
       public         heap r       hospitals_owner    false            �            1259    24646    treatment_record_t_id_seq    SEQUENCE     �   CREATE SEQUENCE public.treatment_record_t_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.treatment_record_t_id_seq;
       public               hospitals_owner    false    237            �           0    0    treatment_record_t_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.treatment_record_t_id_seq OWNED BY public.treatment_record.t_id;
          public               hospitals_owner    false    238            �           2604    24762    appointment a_id    DEFAULT     t   ALTER TABLE ONLY public.appointment ALTER COLUMN a_id SET DEFAULT nextval('public.appointment_a_id_seq'::regclass);
 ?   ALTER TABLE public.appointment ALTER COLUMN a_id DROP DEFAULT;
       public               hospitals_owner    false    218    217            �           2604    24764    doctor d_id    DEFAULT     j   ALTER TABLE ONLY public.doctor ALTER COLUMN d_id SET DEFAULT nextval('public.doctor_d_id_seq'::regclass);
 :   ALTER TABLE public.doctor ALTER COLUMN d_id DROP DEFAULT;
       public               hospitals_owner    false    220    219            �           2604    24765    hospital_details h_id    DEFAULT     ~   ALTER TABLE ONLY public.hospital_details ALTER COLUMN h_id SET DEFAULT nextval('public.hospital_details_h_id_seq'::regclass);
 D   ALTER TABLE public.hospital_details ALTER COLUMN h_id DROP DEFAULT;
       public               hospitals_owner    false    222    221            �           2604    24766    insurance i_id    DEFAULT     p   ALTER TABLE ONLY public.insurance ALTER COLUMN i_id SET DEFAULT nextval('public.insurance_i_id_seq'::regclass);
 =   ALTER TABLE public.insurance ALTER COLUMN i_id DROP DEFAULT;
       public               hospitals_owner    false    224    223            �           2604    24767    medical_equipment e_id    DEFAULT     �   ALTER TABLE ONLY public.medical_equipment ALTER COLUMN e_id SET DEFAULT nextval('public.medical_equipment_e_id_seq'::regclass);
 E   ALTER TABLE public.medical_equipment ALTER COLUMN e_id DROP DEFAULT;
       public               hospitals_owner    false    226    225            �           2604    24768    patient p_id    DEFAULT     l   ALTER TABLE ONLY public.patient ALTER COLUMN p_id SET DEFAULT nextval('public.patient_p_id_seq'::regclass);
 ;   ALTER TABLE public.patient ALTER COLUMN p_id DROP DEFAULT;
       public               hospitals_owner    false    228    227            �           2604    24769 	   room r_id    DEFAULT     f   ALTER TABLE ONLY public.room ALTER COLUMN r_id SET DEFAULT nextval('public.room_r_id_seq'::regclass);
 8   ALTER TABLE public.room ALTER COLUMN r_id DROP DEFAULT;
       public               hospitals_owner    false    230    229            �           2604    24770    speciality s_id    DEFAULT     r   ALTER TABLE ONLY public.speciality ALTER COLUMN s_id SET DEFAULT nextval('public.speciality_s_id_seq'::regclass);
 >   ALTER TABLE public.speciality ALTER COLUMN s_id DROP DEFAULT;
       public               hospitals_owner    false    232    231            �           2604    24771 
   staff s_id    DEFAULT     h   ALTER TABLE ONLY public.staff ALTER COLUMN s_id SET DEFAULT nextval('public.staff_s_id_seq'::regclass);
 9   ALTER TABLE public.staff ALTER COLUMN s_id DROP DEFAULT;
       public               hospitals_owner    false    234    233            �           2604    24772 	   test t_id    DEFAULT     f   ALTER TABLE ONLY public.test ALTER COLUMN t_id SET DEFAULT nextval('public.test_t_id_seq'::regclass);
 8   ALTER TABLE public.test ALTER COLUMN t_id DROP DEFAULT;
       public               hospitals_owner    false    236    235            �           2604    24774    treatment_record t_id    DEFAULT     ~   ALTER TABLE ONLY public.treatment_record ALTER COLUMN t_id SET DEFAULT nextval('public.treatment_record_t_id_seq'::regclass);
 D   ALTER TABLE public.treatment_record ALTER COLUMN t_id DROP DEFAULT;
       public               hospitals_owner    false    238    237            a          0    24576    appointment 
   TABLE DATA           }   COPY public.appointment (a_id, patient_id, doctor_id, appointment_date, appointment_time, status, reason, notes) FROM stdin;
    public               hospitals_owner    false    217   s       c          0    24586    doctor 
   TABLE DATA           �   COPY public.doctor (d_id, name, phone_number, email, s_id, h_id, address, qualification, experience, schedule, consultation_fee) FROM stdin;
    public               hospitals_owner    false    219   v       e          0    24592    hospital_details 
   TABLE DATA           �   COPY public.hospital_details (h_id, name, city, address, phone_number, email, website, type, rating, number_of_beds, established_year) FROM stdin;
    public               hospitals_owner    false    221   ry       g          0    24598 	   insurance 
   TABLE DATA           b   COPY public.insurance (i_id, name, contact_number, address, email, website, accepted) FROM stdin;
    public               hospitals_owner    false    223   �}       i          0    24605    medical_equipment 
   TABLE DATA           i   COPY public.medical_equipment (e_id, h_id, name, quantity, status, maintenance_date, vendor) FROM stdin;
    public               hospitals_owner    false    225   +�       k          0    24609    patient 
   TABLE DATA           w   COPY public.patient (p_id, name, date_of_birth, gender, contact_number, email, address, emergency_contact) FROM stdin;
    public               hospitals_owner    false    227   T�       m          0    24615    room 
   TABLE DATA           [   COPY public.room (r_id, h_id, room_number, room_type, status, charges_per_day) FROM stdin;
    public               hospitals_owner    false    229   J�       o          0    24619 
   speciality 
   TABLE DATA           S   COPY public.speciality (s_id, name, description, avg_consultation_fee) FROM stdin;
    public               hospitals_owner    false    231   f�       q          0    24625    staff 
   TABLE DATA           [   COPY public.staff (s_id, h_id, name, role, phone_number, email, shift, salary) FROM stdin;
    public               hospitals_owner    false    233   K�       s          0    24629    test 
   TABLE DATA           Y   COPY public.test (t_id, name, description, cost, category, result_timeframe) FROM stdin;
    public               hospitals_owner    false    235   -�       u          0    24641    treatment_record 
   TABLE DATA           �   COPY public.treatment_record (t_id, patient_id, doctor_id, date_of_treatment, diagnosis, prescription, follow_up, notes) FROM stdin;
    public               hospitals_owner    false    237   X�       �           0    0    appointment_a_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.appointment_a_id_seq', 25, true);
          public               hospitals_owner    false    218            �           0    0    doctor_d_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.doctor_d_id_seq', 20, true);
          public               hospitals_owner    false    220            �           0    0    hospital_details_h_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.hospital_details_h_id_seq', 21, true);
          public               hospitals_owner    false    222            �           0    0    insurance_i_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.insurance_i_id_seq', 22, true);
          public               hospitals_owner    false    224            �           0    0    medical_equipment_e_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.medical_equipment_e_id_seq', 22, true);
          public               hospitals_owner    false    226            �           0    0    patient_p_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.patient_p_id_seq', 25, true);
          public               hospitals_owner    false    228            �           0    0    room_r_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.room_r_id_seq', 23, true);
          public               hospitals_owner    false    230            �           0    0    speciality_s_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.speciality_s_id_seq', 21, true);
          public               hospitals_owner    false    232            �           0    0    staff_s_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.staff_s_id_seq', 22, true);
          public               hospitals_owner    false    234            �           0    0    test_t_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.test_t_id_seq', 24, true);
          public               hospitals_owner    false    236            �           0    0    treatment_record_t_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.treatment_record_t_id_seq', 25, true);
          public               hospitals_owner    false    238            �           2606    24661    appointment appointment_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (a_id);
 F   ALTER TABLE ONLY public.appointment DROP CONSTRAINT appointment_pkey;
       public                 hospitals_owner    false    217            �           2606    24665    doctor doctor_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (d_id);
 <   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_pkey;
       public                 hospitals_owner    false    219            �           2606    24667 &   hospital_details hospital_details_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.hospital_details
    ADD CONSTRAINT hospital_details_pkey PRIMARY KEY (h_id);
 P   ALTER TABLE ONLY public.hospital_details DROP CONSTRAINT hospital_details_pkey;
       public                 hospitals_owner    false    221            �           2606    24669    insurance insurance_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.insurance
    ADD CONSTRAINT insurance_pkey PRIMARY KEY (i_id);
 B   ALTER TABLE ONLY public.insurance DROP CONSTRAINT insurance_pkey;
       public                 hospitals_owner    false    223            �           2606    24671 (   medical_equipment medical_equipment_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.medical_equipment
    ADD CONSTRAINT medical_equipment_pkey PRIMARY KEY (e_id);
 R   ALTER TABLE ONLY public.medical_equipment DROP CONSTRAINT medical_equipment_pkey;
       public                 hospitals_owner    false    225            �           2606    24673    patient patient_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (p_id);
 >   ALTER TABLE ONLY public.patient DROP CONSTRAINT patient_pkey;
       public                 hospitals_owner    false    227            �           2606    24675    room room_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (r_id);
 8   ALTER TABLE ONLY public.room DROP CONSTRAINT room_pkey;
       public                 hospitals_owner    false    229            �           2606    24677    speciality speciality_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.speciality
    ADD CONSTRAINT speciality_pkey PRIMARY KEY (s_id);
 D   ALTER TABLE ONLY public.speciality DROP CONSTRAINT speciality_pkey;
       public                 hospitals_owner    false    231            �           2606    24679    staff staff_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (s_id);
 :   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_pkey;
       public                 hospitals_owner    false    233            �           2606    24681    test test_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (t_id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public                 hospitals_owner    false    235            �           2606    24685 &   treatment_record treatment_record_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.treatment_record
    ADD CONSTRAINT treatment_record_pkey PRIMARY KEY (t_id);
 P   ALTER TABLE ONLY public.treatment_record DROP CONSTRAINT treatment_record_pkey;
       public                 hospitals_owner    false    237            �           2606    24686 &   appointment appointment_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctor(d_id);
 P   ALTER TABLE ONLY public.appointment DROP CONSTRAINT appointment_doctor_id_fkey;
       public               hospitals_owner    false    219    217    3252            �           2606    24691 '   appointment appointment_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 Q   ALTER TABLE ONLY public.appointment DROP CONSTRAINT appointment_patient_id_fkey;
       public               hospitals_owner    false    227    3260    217            �           2606    24711    doctor doctor_h_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 A   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_h_id_fkey;
       public               hospitals_owner    false    219    3254    221            �           2606    24716    doctor doctor_s_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_s_id_fkey FOREIGN KEY (s_id) REFERENCES public.speciality(s_id);
 A   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_s_id_fkey;
       public               hospitals_owner    false    3264    219    231            �           2606    24721 -   medical_equipment medical_equipment_h_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medical_equipment
    ADD CONSTRAINT medical_equipment_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 W   ALTER TABLE ONLY public.medical_equipment DROP CONSTRAINT medical_equipment_h_id_fkey;
       public               hospitals_owner    false    221    225    3254            �           2606    24726    room room_h_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 =   ALTER TABLE ONLY public.room DROP CONSTRAINT room_h_id_fkey;
       public               hospitals_owner    false    3254    221    229            �           2606    24731    staff staff_h_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_h_id_fkey FOREIGN KEY (h_id) REFERENCES public.hospital_details(h_id);
 ?   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_h_id_fkey;
       public               hospitals_owner    false    233    3254    221            �           2606    24751 0   treatment_record treatment_record_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.treatment_record
    ADD CONSTRAINT treatment_record_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctor(d_id);
 Z   ALTER TABLE ONLY public.treatment_record DROP CONSTRAINT treatment_record_doctor_id_fkey;
       public               hospitals_owner    false    3252    219    237            �           2606    24756 1   treatment_record treatment_record_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.treatment_record
    ADD CONSTRAINT treatment_record_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(p_id);
 [   ALTER TABLE ONLY public.treatment_record DROP CONSTRAINT treatment_record_patient_id_fkey;
       public               hospitals_owner    false    237    227    3260            /           826    16391     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     {   ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;
          public               cloud_admin    false            .           826    16390    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     x   ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;
          public               cloud_admin    false            a   �  x�u��n�0���S�\��{sM�AR=�BK�ń"�r�����:�9���v8�4�M����N�xX(kUuFU��uQ[��|�Zv��r֟�Ŝ����o��oҵ|������8W�֫:�����
&ěP�֨HB���д�5�=�f��VU�Q�.e��f3Fg��'bJ�'~n��Z^::��C5sFg�-����ı�O,d�4�� �{����;cx���5��RV�]�D��JY\Jdc����T����!�]�
��ն���+�ƴR[v�lt�<׍���*Đ��h�DVLg�>p�\y#_���K�m�Д9[&�5���N�8X�T����! d�c��l��`�Q(�21?gF�Q��t��4��vQ�0���:i���3pn�)��Ъ�*�Niw���f&
xB��fbqf뻒��0{�v$
;���Bb+B$	L��,��Wm���f�\�tdӏ�Pa�Ӈx����k;\?<�!Oޙ���+��Q�"M}O�s"�4��V��&^���7Ѓ#���D��sv۴���?r�"Ix�v�X��~c�8��#'�wF��B�ך��Du�J���0��z �W��$K=}hӛLAK8�Zz@"�%Kw��<��sHb�򴽒�-��>���q���n�ɏX'���z���X��yL�Z�Moܞ�0�Z�+sInvi%]�XSToC�	�n$��%��{<����,!8��ϖ�3U?�ϦCOp�	�qOBc�bO��ꋵw2��q�9��I��,��
�      c   N  x�m��n�0���S�lB��o��4E�A4�^h����Ǡ�y��.EKl��?�����{W�|�T}ɒ$��2��h���G5�Z�]װ�U��;�T��z���v��T3^�f���I��2��9v-A�4�Y�x������IʿiU�%_�,%a�z�Q���`b���Q����Ζ�gi�(�-�$�'������#_֧=rr�E�g<�����(wM�����,EL�(�$z�xp�n���1�oN%t~B��-����;=d%J���;;l���������h���N�(�J�\v�a2@Ď��~�=N:8u��ʸ)�q
t)BND��8O�V��[:pbfH����Bβ2��M$�q"�+EPH���B�����7Pľ���Ѯ(����GOS,��a���G;�[vA��H=*���O�D@����V���Jm�1������D�� b����/��9:Fƶ(
���� lB
jehŕ����j�j� �F�J/���"��z�F��U�-�����^�t�_ʪ�,�`GR�U�!��"φH��j9�:s��-��Gg`�Z��6��4�E�GD��>�	'��O뗻�I���-��+����/p`ge񊲏��!l�]��H@���-Fe������몮�q$���!�%��pwN��إ���m���^֗�9��ߍo��T�wgtmr��i�3��*�Pw�+u=����k$��9./ڍ�xy���ٲ�ԩ�{IO�(^Kr���^��+�r	�PH��E������Oq&�G���2�+s�����G+��{ev�r����.^I���m��]�dx��O��[�����O4�      e     x�mV�n�6}}`Ruysⴛɮ/Z�#3�4$�i��R�d�z���Ùs�lT�Em{T���C~��m�,NȳP��:�Y��s�c)(�f�&�CΪ����\���W�*HW��ʂF1|o�4�O���"��e'���Rme!��)>��YBʸ��X�5��������o����O��:�/[�P���<J`w2m��$�R�&i:���mɝy�Z��%v�%y�C¨
)�Rk�n�+j������(+%��O��dbJy���J
sV����J0JɽU�Hh�Ҟ�F�yd*�A��8<��`��P1��:-+&/�l��f����ī:o��2s����QO�C�j/'�mjU�w��	�K��W��8��C���9���ʒU	,�*�Q���Iܔ��hz��`���%mݨ�%�N������K�rw����g,:N�RhOǣm�Q\��QV���NNN�qTB/�')ަf����7�?G]�l���:�#���$��x0��C��3��Q؊J��*���Tw�v�g�є��|u|L�?���W���NL$���,1��e�Y���hOmg�r�5���ld }F4r-C�<�w�s��$b1�:�h�^w�}�"�Z�="fd�t�D��W/	�3���S��7Uo",�m|��b��C����<cy�-''w��\|��M �C~SxR���\w��N b��J���*MH$&���oV�R|�"G����lO�C�ㅡ<�|�1Z�����d�4
"���%ט;"�#���ݓ����ֲ1Wc�QF��˕��`dfȿ�B���Joje�r��'�ۏ��|P�y(c����;J�����L�bn�1����9ϩ�W4J�L6��>��b�wW��0������I͗���aI`�Kؠ�4�튅=����6�E�jª\�[��g�QL��IR�'	����ޡS(� �μ�O�Y��֟.|̂�^Y�1f���3)�u���{�/�s� �s�+:�#���O�]����b3E{r��UE���#�      g   �  x��TM��0=ۿ����-ɶ����VM���%&A�BjL��������K$�Ǜy󆓽%;�[��D��IJ����QW]o���T�پC��ś�� ��m����wY)s~Q〔"����=�W���d��$�x���l�X|��r��綑Oc���"�ɋ��F�O�W�#i���*�;ٺ�,D���C�%��<��Rf���uU��� C�)��]�q !��9YP�
��f�~��Ճq-F�*�"��`?��,D�� 6�^�R�7�����9�z��:1s��3�����:��}l!dh9	t���K�S�n��[�9�s+yh(��^#���IS M�ckp����}�:�q_�5�P�	��V�L'�N����g��>��T�� ��ɓ���Uƾսo��V���N��)��K,��Z�1sJ�w�@X��ψ�
����K�A�M��~�Ђ�J�/��pK.�i��u����,a-"�9�Cس��� �!��Tx�� �O�7bڰ����Ă`jѓ���cw�\`@q��
�%�	�.]v'<��8oPޔ�K��B~'<e����n�*`+��1��r��D�fn�@��,� )v�z9 ��9E~�_��i�ۆR�H�3o      i     x�}TMs�0=˿B ��cBҖi�21Mz�E��,����ߵM(����ǾU�b�s`�/dQ��2�&Qɵ&F"�b0��6+(J>3�H0��s�Rk�,a���Z�mGƄ�)�R���w�5��b%������4zsd��3�x�2����R<o�Z!�hLbg�#��m+���Q�G�]��i���9��,bԺ�^��Ժh�E�|Q��l��;%p��eb��ĺ���3����36����#[Gw�|�-�-*%�����$yN�7��LZ���
��Ȍ`��/���){����;,�ZZ�s�oX��8&���={ڲ`$��/:$�°�/��v|/�z�(����ê�d�V<&�#J�w�n���3�7���u��Wc���~�v�2o�$ߞ�G�I�?<�;�O�k���#5|�TuP|��4<%��&���
e~m_�-TQ�lԁK�Z�5*���2��;"ʽ_�T�,�w�:�Irz��n_�h�A��K�5$�fY��� �y۴e����lE�+S���z��Y_�w����(�X��^      k   �  x�uU˒�6<_� 
 ߷H��nٻ���k�R�@,�K2Di�>�7�{�@J���M%6{fzz�-�P�E֯�"�gq�������8�"��t��!��w�jEӠPp��lQ�M��q�fX��ْ��){48�,�<=yP��	ښ-��3�#���"��������55yT
s0 �4	���p�i��[��d�vҒ;�a'8Bw�Ԓ�m�O�&B6�!�h� ��!7��q�!����Ub���ji_�'�['d0x�C�@��W ��d�Ck�uj�8AK{���k3���[Ε3F[��� �T@���-esY��q�֪U�����_89tpz�� �C�Sy�R�3��l屔��4R��_]���Ũi�t�v���C�vd��$�E�}6��)���	+���r=:��1"[ �,Zc����7�:+hz>j���F�v�yL�֘׺��c������/R��_�K��,��LY���_��w�(�	��M#��\յ�����h)�����[�E��@ݭCP�3�ܠ`e�2�.l[�,Y��=ת��:n�J����Hs�G���\,����Oa)���M�;��}A���rK���M#���<A/�A�<���\���U��́h3�f���W��p!�x�6�i[�(���0�{m6AG�5 f���%����0�.����H͢��G�eC�<`F��.�O�5��|H�?O�R.���P���1�@�Z�wA#*+�_�� �i�Bѽ�s/��[�4Y_ǎ���D�r�`A*wMi�	}i�{d�Gͨ��[X�$ D�!�>��Ͽ��-ɗ�|=�B�n�&��c��af�)d�nKPr�"Ű���QG�`�j���f�xr�P���в�̈3�b곲�c8n�������p{�W���7xN��|F��ui��ާv�1|I��D���(Mݨk��1���u(���n�}O�^C���� \W      m     x�}��N�0�g�)xN���̀ؐba	w*�?����.��hPF���[t���Ne�z*�ʱcy���ι�@�#��y�����c��V� �y���c��g�d�� MA� ~Ɯ0d��S�*�6C���k�i%e6D�M�""<��������)���K�Z&����ʒ�3EX��[y�j%zvw�X�)�j�xKE%m}?ϖ��.ɊI!���bY)��b���o�DK����e9>�Br�Ŕi�cYX��y�u�7����      o   �  x�eSKn�0]ӧ��@��YƱ���E�M7q"��HcHЮ���z�RJu�����}f��{ ��qU'>"P�`�|5�)yA���@�A�"�n�lV�'l�9OH�z�;���.�GT�ҋ�Z%k�E���x�P�sDF��Y\|w�9 ��{�k���b���8X�J�6�r�8&�!6W!vqR/i��3h�$[q����?���i}ipέ���n1Pnű5Q�'�gM�O�8?Y*6<��o�p�</��K������gr�-���8gv�n����_~��A�x�!�x[��h.��)g��A�Vl��w}��'��'�s�p*�SJ��8�����J�JF�UT�ϴ�|���������@@5�\0r#:�%#��濌��m\��Nm~��b�V�d��x@�:�d�4$%��x�o��f�=���'�O׿њ��8B<��3k/��H��}���f �1�      q   �  x�}U˒�0<_�����[x��ZR�%����
�Ddy	�����E�sw��gzd���lm$<�\�2Z��,�"D�o�ya��ʴG��i��3$YE<�&1������֜4��y�U�P�*I�����~��UY9HG�آE�������V�"Y6�BK?y��L)EZ�.�l�g-a+��*w�D	�=�O���RF�V���Cjw+J!�0?�lЙ���uUg٪���&V"���x�$�fdhM�G��J灍����S����ںƛӬ�H�d����q�>fQ{���9�����['_%{6��퇹�{�an{88��AKD���\�ڼ���B�`�&j
�B"�)Ћ�ZBP����U��\��lѶ$�������x3��f��"��?�>���2����4�)8b�ֳn}N�����o���m�)�3��'�cO
lf:
�~��E,Qk|��ʱfTc���jI���p���~i�WƲ�B��hXu�3��w���ژ�ZS�}o��c�"�^����AR;j��z�oF��3��8y���Yԥ�����Q���I[ꙁ>]�>��ǆ�T��>�B�z�;��ņ�z,8�dԹ���.?�i=V�6t�T����V<哫�#�77�� uy���?�:6�PQ�5�	��)��M��e�E�MƂ�cޥ�k��w��r
�Y챕��i�К��Q���ejS�o�N��=�n`/�#��O&��%      s     x�}U�n�0}�|�?���@(�[�]Wi���N}؋q.�jb#�a�����0�T����s�%����:d�J�-t�� ��A�
�^�A嘠}Zћez�V~3��M�@<���A6��$�7�������\�R�2�ӖqU0'�m�B����H�����Fh��'.e�)�a0��`/��l)��t\VX0y`�M�ՐN>��#�x�@G�H��(^u@0�pxzL�	:q�[k�6�+�a57�h�T�=���K�N
��V+��=;�2\�P��JO�
��DV�֎f�Y׆��H�<ckÅx<��F�*�-dC��#��z�|�G�;]�������ޒ�.�+OE�`i�3�R2��յT;n�{���ϰ���;b��8�(�ϡ��x��
�3ZpSHϳ�cȢF	'���W��f�A�ڒ	�Ҭ3nR�����1ǝ�e�KA�!û�
��:���[�5�ԙ��Ҧ�t�t�4�0L.�*��wӰ��:�Ua�$�]�ţ~	N� �ЋQv?f�|��ۦ5Z�Et�↊�!�d��/Һ�0V�z�����J
�a� ��S�Ǳk��Q.����5*�C�5���-A�+�)��U�C�i�ͤ����9a�`�~@e�kO̊��[B��0p������Y�O��\�m�{��`�w�х�3})Z���/��d)�4X���Q�v��B��45��m"j� ��؛����ى�C���ܠ�ƾ����0������d�d�R�IW�$R������4����=����È'�H��՝4�������f4�	�s�      u   \  x�uUMo�8<S��?�^��口�n��n�E�C��ҳE�"�JW��;�lQn0���q4of޳`'_���R��}�[r��Wְ'�T)��\,������B/<Y��u����x����Q���܀s�I��sЇ��S�cM���w鸦7�>[�x&���;�L>pi*^�������5��Y<��|K�Jeؿ��ip�e�Xv�ޔ'<�!+X<�`j����`�Z(sֲi$D�㋏eMU�	bԽG�����l�l�W�F#�٨3>o�������XU>�B�Y7vК��<�,��?RPN�T�"����r�fU��p�f;�u�e��AK��]m����MC�B�*�˶�WC�=�m�=�. ����������l;SeP�`�to��6D�I���u�L&q؃Ù�;T�7��φ풘K� ��z��ZU�:���-��9�>[��E�f"�}�/���,���Y��])
���Z��L�@	M�,�B��PB;Y���zHOw�� G�N#�S�3�!̊�Y��F��A+�fb���v��Y� &E�!򄱾��WƶN��~o�A�)�y1��_�[�������6�)�9�C��M-��h31�}�۠�]$"R���|焳u��Q�A�讴��Q �#	�b��`65
<%,$��BHޣd�Y55���	1��,$0�����N�������ݠ�nVɉ]�G@�ZU<��1~j#��seHga�|�pV�����FVv�b\�4�2(�Kk|�ØO�m�����c����cjp�d�o���P�3��u^��S�	���Η:.G-��w&,��OVC1mN�m��:�ZvV����	���$��G�e�J�W     