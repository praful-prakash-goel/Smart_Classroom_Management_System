PGDMP  %    ;                }            scms_db    17.5    17.5     >           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            @           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            A           1262    73745    scms_db    DATABASE     z   CREATE DATABASE scms_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE scms_db;
                     nikhil    false            �            1259    90129    attendance_report    TABLE     �   CREATE TABLE public.attendance_report (
    roll_no text NOT NULL,
    subject text NOT NULL,
    attendance_percentage numeric(5,2) NOT NULL
);
 %   DROP TABLE public.attendance_report;
       public         heap r       nikhil    false            �            1259    98335    class_schedule    TABLE     �   CREATE TABLE public.class_schedule (
    offering_id integer NOT NULL,
    semester integer NOT NULL,
    day text NOT NULL,
    subject_code text NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL
);
 "   DROP TABLE public.class_schedule;
       public         heap r       nikhil    false            �            1259    98322    course_offerings    TABLE     �   CREATE TABLE public.course_offerings (
    offering_id integer NOT NULL,
    subject_code text NOT NULL,
    stream text NOT NULL,
    user_id text NOT NULL,
    room_id text NOT NULL
);
 $   DROP TABLE public.course_offerings;
       public         heap r       nikhil    false            �            1259    98321     course_offerings_offering_id_seq    SEQUENCE     �   CREATE SEQUENCE public.course_offerings_offering_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.course_offerings_offering_id_seq;
       public               nikhil    false    221            B           0    0     course_offerings_offering_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.course_offerings_offering_id_seq OWNED BY public.course_offerings.offering_id;
          public               nikhil    false    220            �            1259    73747    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    user_id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    password text NOT NULL,
    user_type text NOT NULL,
    face_id text,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT users_user_type_check CHECK ((user_type = ANY (ARRAY['student'::text, 'faculty'::text])))
);
    DROP TABLE public.users;
       public         heap r       nikhil    false            �            1259    73746    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               nikhil    false    218            C           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               nikhil    false    217            �           2604    98325    course_offerings offering_id    DEFAULT     �   ALTER TABLE ONLY public.course_offerings ALTER COLUMN offering_id SET DEFAULT nextval('public.course_offerings_offering_id_seq'::regclass);
 K   ALTER TABLE public.course_offerings ALTER COLUMN offering_id DROP DEFAULT;
       public               nikhil    false    221    220    221            �           2604    73750    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               nikhil    false    217    218    218            8          0    90129    attendance_report 
   TABLE DATA           T   COPY public.attendance_report (roll_no, subject, attendance_percentage) FROM stdin;
    public               nikhil    false    219   "       ;          0    98335    class_schedule 
   TABLE DATA           h   COPY public.class_schedule (offering_id, semester, day, subject_code, start_time, end_time) FROM stdin;
    public               nikhil    false    222   3       :          0    98322    course_offerings 
   TABLE DATA           _   COPY public.course_offerings (offering_id, subject_code, stream, user_id, room_id) FROM stdin;
    public               nikhil    false    221   4       7          0    73747    users 
   TABLE DATA           j   COPY public.users (id, user_id, name, email, phone, password, user_type, face_id, created_at) FROM stdin;
    public               nikhil    false    218   �4       D           0    0     course_offerings_offering_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.course_offerings_offering_id_seq', 1, false);
          public               nikhil    false    220            E           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 11, true);
          public               nikhil    false    217            �           2606    90135 (   attendance_report attendance_report_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.attendance_report
    ADD CONSTRAINT attendance_report_pkey PRIMARY KEY (roll_no, subject);
 R   ALTER TABLE ONLY public.attendance_report DROP CONSTRAINT attendance_report_pkey;
       public                 nikhil    false    219    219            �           2606    98341 "   class_schedule class_schedule_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.class_schedule
    ADD CONSTRAINT class_schedule_pkey PRIMARY KEY (offering_id);
 L   ALTER TABLE ONLY public.class_schedule DROP CONSTRAINT class_schedule_pkey;
       public                 nikhil    false    222            �           2606    98329 &   course_offerings course_offerings_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.course_offerings
    ADD CONSTRAINT course_offerings_pkey PRIMARY KEY (offering_id);
 P   ALTER TABLE ONLY public.course_offerings DROP CONSTRAINT course_offerings_pkey;
       public                 nikhil    false    221            �           2606    73760    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 nikhil    false    218            �           2606    73756    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 nikhil    false    218            �           2606    73758    users users_user_id_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_id_key UNIQUE (user_id);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_user_id_key;
       public                 nikhil    false    218            �           2606    98342 .   class_schedule class_schedule_offering_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.class_schedule
    ADD CONSTRAINT class_schedule_offering_id_fkey FOREIGN KEY (offering_id) REFERENCES public.course_offerings(offering_id);
 X   ALTER TABLE ONLY public.class_schedule DROP CONSTRAINT class_schedule_offering_id_fkey;
       public               nikhil    false    4768    221    222            �           2606    98347    class_schedule fk_offering    FK CONSTRAINT     �   ALTER TABLE ONLY public.class_schedule
    ADD CONSTRAINT fk_offering FOREIGN KEY (offering_id) REFERENCES public.course_offerings(offering_id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.class_schedule DROP CONSTRAINT fk_offering;
       public               nikhil    false    221    222    4768            8      x��\���������wh`G6�D�d����{����cL��q�3|V�X��$)ɇ_>������?�������.��z����ۏ��_�������|���-_M������~����O��������߾y�����+}�1�賍��Z�������U~������1��������<ۘWI@�m�t���F���Qm�r����^�?�Q�n_i�5_�P�d�׼��X3j���6����6��C�f�l=fJ�n�f~j��Km=�s=��;P�zI~l�]��$��9%sU�:��C�Å�]I����W��kU�!O��
�����<׫�8�+VK�׿���6֌�8�<_��|x��:�|��YV!<oWs��G�j~�Wkͭ'O�����!Wv<hc�� <_�_��5��5r�y��8�<��AϷ%���{w\j�����V@(ϗ���k��%<�WJ@�8:v��y��aVM	ϗ��d>N=�|�cXO�<�3�@)�� �v���cJ�y����;��A�y�� J�1�g�7�������ԀR[R2���Z|�O���P��+G̕�l<y��y{e<_q"v̙�SaY���ۭ���f&���Ȉ,��\�!@��E�?X�Lx�a+2��	~0�y�VM��'�w̠@Iqb�y�����|t�d=*b�|���^�WO�/�h�U�<_3]�q�ܫ�)�1WԟOĪ���mY�W��>*3���_��}����/(ٻ�{x���}��'ϧ���!���;��L���bf�g�����Y��Zd�g�<S����2�����u���=�<ػ�!ʓ��s���A�X˙��&Z4?�5/��+ϒ<���Փ��ҘU.��ˢN�?���*O��5�(�`Ǿ*a~n޲��=��P(�3v~	����Bx>�����.A��_!q��j1��jK�j�a�'�Wh�Ma<_��*!������*O�/�+(�����
OW	ϗ��@i-��]y����ğ�E�<_�������ΞJ�y���A�^�y�y}�|�������3ϗ�*6W$?��Ge<_V�b���rU��'�W��:P�w-����l$?O�ו��x��q�m���k��ԟ�W<�W��+�s�Ҹݫ�5��	6�>y���圕�|�� �E�ў<_��΍����3ϛ�����b&��=�iA�>�4��+�F��e�&����S�{��Q�j�v|��`���=oA~�}�	������A���� <W�>�������˶ۯ�?��F�p��#�G/������_f:��͓5Zo7��ך[t��<_,*���c(��� ����t�/�_��ڒ�=��Ν��j`���gx���N�p�����+�=���*���$nO��:��/m�|�[5��
�u�s�{��俢�j�u��5�x���:��0�3��_��%�8��-�s5�wT��"q{�����~\���� q��$��ODN#��տB�vc�u���������?
P�s��#8Wk����su������s?�����s�G���O��]g��A���O��狩�j��>�Zo�>Wa�x>Hn ��+nq<��b�O�/�h��<��F��\���s�9ǁ�v�8�R�>	Ͻ�1)����j}����(���(�-�$�<��|R�L��\��Ix���y:?/�?hgۓ����I��*�����=�<ǎ��� Ǚ��y��m-&��^[���t<�W�S�Ͻ^2in���@'�3�W�ހ��s���ta�s5q�v�53������$r��V��(��ܵ����wUR�.�m���z��"���w�9���v]t l	~E��d��P=�ڕw�R=�>���R=\�4MxT#�%�jɼ�P=��^
� N�6ZZ��\Q�3J	�p�+�FK�v��ϓ�I���2B�p�� �sU�$?����U<%��x!z�]�@�9gv<�E������T7P	�@����r
��u�����<�l"�Ax�>Wԟ#�@�zz���V�����ἆ,D�뻎Ҙ���O��ϡq���1� ~NC���&<�p=��8�:N}����\����=���N�p[�1�R[2x�?�(M�n��(�L��������֎���z�G&�w�;߳A�p;2�@�M��
�p+Ǳ5'z������v\�����>y�m� %�V�@�O߬����P=��*�(޵U#<��AT���<�5�f� �<YT/T�l&�<Է��"z�]�n@�')��-��x���:{��6��=��5��&Z=܀�J�nק2PZC.��h�qPn��z�i6	�p�^r�8��5��T��f�G�7����((����%�����FKx>���P=��Qz��}�i�,&��!��@נ0���YVJs���ܢf��k�׃��b'���G�D�J6�z���*เD�p�G�n߈����.��-{d�}�á� nw�=�>-@��M��8��+��ۙ� �m���p6��uXe��[;s��=�!z�]�L@i��v��k'=܊;j�k�� ��J��5hՄ��-I���ۭ���ٝP=��&���.*D���(?Km�[b�`z�
�I�p���@�R�bz8������� �n�!�ѷCs*T�}T��Zn��p/sE�p�N�$��dBD�<��z�eK��z��m�Wh�sE�BU.�n��l�ϓ��
��u�=\�8������sܿ�@��;[O��l7��m�����2�F�p~P�n��R�A��F�n�\Nz8�W�n1�v8�õ�A��� �f9�n�O&P:��b=f���M��\���@�R� z�}�d���[�"�n�XO����u�]�@��`���-ǧz�����A�}��=����tƏ@��G�Π��W��f�q�����5��T��0x��=az��\���
�y��` ��u�����ޝ
<��[���ᶢ[����<�VOdz8�jq=\B���&N������p=܀�	�p����A��۵���^+�`��#=ܾ?ہ�<�e��!z�	]�P=��mK���se;��9?u8�{=�>�}��5�T��3H���~�B�p;��@y���j ���l�����H�v�R�nזPS[������{F���RN�p��%��uS
���ܠ�Z5�3<W�J�����z�}�H��Wc2��m��Ҹ�lM������{,v�O�p��$��-[bY��5��!T�/�H���7��+��ng^T���G{��+���oUd���3�+�}D�"U�T�ߕ*�̈́��L����ٴ���&^3��[�ߴT���x�5�l�'��p=\���p��}7�e�\ЀG�>�
��:}��L�g�p/�<���л	�ýĻ�n��ی�s��z:��U(�=\�����e�z�sg���:�2=�)����C�w�ܖS�nB��T�c�<��&�	=W���K&��8�jK��p�Ք�W^�}�`�%�9�R��K��ϡ�R�>�]!P��Cܢ�9�2=�r�z8W�h���3(��!2R��+vnזlFI�>����}�	<�_YO�;�Q����~��\��k��߇��k���-�Dא�*�á���pݿBx�8P���N�z���8J�p����a�߇�\Ѹ������t���:��J�p{o6�T9�߁M�3(��^q=�X\��n߮�����,@i]�%�A���x�{,f%=��9X5�>\V�4�x��5�3>%z�e+��z���]=���Aez8TД���ˈxP��
9W��J��5��&���އ����}�f5 �pkgd�	׷+P��ԁk.�r/UMݫT�����]��L]�R=�V�4����FKx.��(�é�f5zn����JJ��'z��=����F9Jy��q�ە��&����S��&<�ù�D��p�!��n߉�_Q��zP=�~#����BD���t�\;��_����{���p�����b�=ܮ�&�4��\���ŢD���(=70{�ᶏ�� �L@ �   ��}8���p��YOIܞL_�\����:ލR��[se�����+�<ȣ���}�+��pv ��u��(��M���'=ܘ��3H�9��M�R��������e��pkJ�p�Z�z�ݓ{w=���(=�0���Vf~���W!���5�@7P�W���w�
P��0��P({N�ΦT�5�x`�C=��ە��:4����L�n��4:W��}8���D�w���ᶇ��\���������Xy      ;   �   x�m�?�0�9�0r������ũ��.
�~{4�t(�G�񞶬X��p��}�F+p[��Q~/��f�0~SZGT't�(~S#j
�Q@���zz�vHb���H�Ԙ%�,S:W�21�M���=�529H�kP����=Y���4���9O�������<������n�ױ����L�v,��Q���}����L7kimkǐ��*/��kĥ���.����
u�%      :   �   x�]�;� �N�Tؼ�
E�N�]����v����ۘ�޴�h�8�c��âh Gf��}ߎ�w�Ғᕍ��Y�,�Ǖ�ٕ5M�C�Yp�y�(�
S�#R�fo<��e��.���k�4i����KC2ώ2��W�SV���1j�w�M�^�T�:�:\*+(^�cTE�<i�R�(�Y00�C��P��|���f���3g      7   �  x�u�Ks�L��ͯ`���}�J4*�D�O��*��A(����g25�s��y�s0��2�~Y�v������ɶ��"�"K�Q�x �F	�ڣh:K�q���4�����������~A7G���"�\���U���
�� �����k�i�A*a3�B�T�(	��RFy"��� s���a,q�Tv�O!�zkрŧc�bEcp�@SU![��{Z�o6����ء�o0�4F �)�oE$��ㅑ8;����)�g�	�H���\�$�b���Ɋn�s�dԴ$N��?�}a�h��[n������`�xuZ���Ec
�s�
�e���4��n�.��z���3�ҬֽB��awzʌ����z��s��V[�@�Q�t�ڃvaO���L����a���#"jũB� �rIP?���Y_�������
$�}���
���(���*�dI��nǝ!_٤ʶ���9!F0���]�ՋZ�X1��j�Qu6�����~f��A��*���4�@Je�_2�|oS�b[��a�g����;�DUE���7��ՠGC��c�u$�]����&�a���"1ߞ�ߐe���z��x��=����PϾ��Q
%Ib*0q0v��c{q� �쿊�n�M��^����Dk�4�Xo�ۨ&ˮ����){�%r�b�
��o�f��xw[һ��6�/J�a~�$��0~AA~)3Ld     