*===================================================================
** JDC project on labor market of migrants and refugees 2015-2025 **
**  BM-JDC-ACNUR     ***********************************************                                                  
*===================================================================

*Prepared by: Ana Rivadeneira, Andrea Toledo
*Created Oct 22, 2026


clear all
*set dp comma 
set more off 
global master "/Users/Library/CloudStorage/OneDrive-Personal/Documentos/Banco Mundial/Migracion_cpv2022/Bases"
global graficos "/UsersLibrary/CloudStorage/OneDrive-Personal/Documentos/Banco Mundial/Migracion_cpv2022/Graficos"
global mapas "/Users/Library/CloudStorage/OneDrive-Personal/Documentos/Banco Mundial/Migracion_cpv2022/SHP"

*** Load Data
use "$master/viv_hog_pob_cpv_2022.dta"

** Label data
* Add variable labels and value labels
tab periodo
tab1 p15aa p15ab

gen nac=1 if inlist(p15aa,1,2)
replace nac = 2 if p15aa==3 & p15ab==170
replace nac = 3 if p15aa==3 & p15ab==862
replace nac = 4 if p15aa==3 & nac==.
tab year nac
tab year nac [iw=fexp]


qui {
label variable i01 "Provincia"
label variable i02 "Identificador de Cantón"
label variable i03 "Identificador de Parroquia"
label variable i04 "Zona"
label variable i05 "Sector"
label variable i10 "Número de vivienda"
label variable inh "Número de hogar"
label variable h01 "Número de dormitorios"
label variable h02 "Cuarto o espacio exclusivo para cocinar"
label variable h03 "Disponibilidad de servicio higiénico, inodoro o escusado"
label variable h04 "Disponibilidad de espacio con instalaciones y/o ducha para bañarse"
label variable h05 "Principal combustible o energía para cocinar"
label variable h06 "Principalmente, el agua que beben los miembros del hogar"
label variable h0701 "Acostumbra separar la basura en orgánica e inorgánica"
label variable h0702 "Acostumbra separar desperdicios para dar a los animales o plantas"
label variable h0703 "Acostumbra separar papel, cartón, plástico o vidrio para vender, regalar o reutilizar"
label variable h0801 "Tiene este hogar perros"
label variable h0801n "Número de perros"
label variable h0802 "Tiene este hogar gatos"
label variable h0802n "Número de gatos"
label variable h09 "Tenencia o propiedad de la vivienda"
label variable h1001 "Dispone de servicio de teléfono convencional"
label variable h1002 "Dispone de servicio de teléfono celular"
label variable h1003 "Dispone de servicio de televisión pagada"
label variable h1004 "Dispone de servicio de internet fijo"
label variable h1005 "Dispone de computadora"
label variable h1006 "Dispone de refrigeradora"
label variable h1007 "Dispone de máquina lavadora de ropa"
label variable h1008 "Dispone de máquina secadora de ropa"
label variable h1009 "Dispone de horno microondas"
label variable h1010 "Dispone de máquina extractora de olores"
label variable h1011 "Dispone de automóvil o camioneta para uso exclusivo"
label variable h1012 "Dispone de motocicleta para uso exclusivo"
label variable h11 "Alguna persona falleció en los últimos tres años (a partir de enero 2020)"
label variable h1101 "Número de personas fallecidas"
label variable h12 "Alguna persona viajó a otro país y todavía no regresa (a partir de nov. 2010)"
label variable h1201 "Número de personas emigrantes"
label variable h1301 "Total de hombres en el hogar"
label variable h1302 "Total de mujeres en el hogar"
label variable h1303 "Total de personas en el hogar"
label variable h15 "Existe alguna persona que no haya sido mencionada en el hogar"
label variable aur "Área urbana o rural"
label variable canton "Cantón"
label variable parroq "Cabecera cantonal o parroquia rural"
label variable id_viv "Identificador de la vivienda"
label variable id_hog "Identificador del hogar"
label variable h01r "Número de dormitorios (recodificada)"
label variable imp_vopa "Registro imputado en vivienda ocupada con personas ausentes"
label variable d01 "Tipo de vía"
label variable v01 "Tipo de vivienda"
label variable v0201 "Condición de ocupación de vivienda particular"
label variable v0202 "Condición de ocupación de vivienda colectiva"
label variable v03 "Material predominante del techo o cubierta"
label variable v04 "Estado del techo o cubierta"
label variable v05 "Material predominante de las paredes exteriores"
label variable v06 "Estado de las paredes exteriores"
label variable v07 "Material predominante del piso"
label variable v08 "Estado del piso"
label variable v09 "El agua que recibe la vivienda es"
label variable v10 "El agua que recibe la vivienda proviene o es suministrada por"
label variable v11 "El servicio higiénico de la vivienda es"
label variable v12 "Disponibilidad de energía eléctrica por red pública"
label variable v13 "Disponibilidad de otra fuente de energía eléctrica"
label variable v14 "Eliminación de la basura"
label variable v15 "Número de cuartos"
label variable v16 "Todas las personas comparten un mismo gasto para la alimentación"
label variable v17 "Número de hogares"
label variable totfall "Total de fallecidos de la vivienda"
label variable totemi "Total de emigrantes de la vivienda"
label variable totper "Total de personas de la vivienda"
label variable v0201r "Condición de ocupación de vivienda particular (recodificada)"
label variable v15r "Número de cuartos (recodificada)"
label variable p00 "Número de persona"
label variable p01 "Parentesco o relación con el representante del hogar"
label variable p02 "Sexo al nacer"
label variable p03 "Años cumplidos"
label variable p05 "Inscrito en el Registro Civil Ecuatoriano"
label variable p0601 "Tiene número de cédula de ciudadanía o de identidad ecuatoriana"
label variable p0602 "Tiene otro documento de identidad"
label variable p0701 "Tiene dificultad permanente para caminar, subir o bajar gradas/escaleras"
label variable p0702 "Tiene dificultad permanente para bañarse, vestirse o alimentarse por sí mismo"
label variable p0703 "Tiene dificultad permanente para hablar, comunicarse o conversar"
label variable p0704 "Tiene dificultad permanente para oír, aun usando aparato auditivo"
label variable p0705 "Tiene dificultad permanente para ver, aun usando lentes"
label variable p0706 "Tiene dificultad permanente para recordar, entender o concentrase"
label variable p08 "En dónde nació"
label variable p08p "Provincia de nacimiento"
label variable p08c "Cantón de nacimiento"
label variable p08q "Ciudad o parroquia de nacimiento"
label variable p0803a "En que año llegó al Ecuador"
label variable p09 "Hace 5 años en que lugar vivía habitualmente"
label variable p09p "Provincia dónde vivía hace 5 años"
label variable p09c "Cantón dónde vivía hace 5 años"
label variable p09q "Ciudad o parroquia dónde vivía hace 5 años"
label variable p1001 "Habla o se comunica en idioma o lengua indígena"
label variable p1002 "Habla o se comunica en idioma castellano/español"
label variable p1003 "Habla o se comunica en idioma extranjero"
label variable p1004 "Se comunica en lengua de señas ecuatoriana"
label variable p1005 "No habla/ No se comunica"
label variable p1001i "Idioma o lengua indígena que habla"
label variable p11r "Cómo se identifica según su cultura y costumbres"
label variable p1108 "Otra identificación según su cultura y costumbres"
label variable p12 "Nacionalidad o Pueblo Indígena al que pertenece"
label variable p13 "La mamá o el papá, habla o hablaba idioma indígena"
label variable p15 "Asiste actualmente a educación regular o formal"
label variable p16 "El establecimiento de enseñanza al que asiste es"
label variable p17r "Nivel de instrucción más alto al que asiste o asistió"
label variable p18r "Grado, curso o año más alto que aprobó"
label variable p19 "Sabe leer y escribir"
label variable p20 "Obtuvo algún título en el nivel que indica"
label variable p2101 "En los últimos tres meses ha utilizado teléfono celular"
label variable p2102 "En los últimos tres meses ha utilizado internet"
label variable p2103 "En los últimos tres meses ha utilizado computador o laptop"
label variable p2104 "En los últimos tres meses ha utilizado tablet"
label variable p22 "La semana pasada"
label variable p23 "El trabajo que realizó fue en labores agrícolas, cría de animales o pesca"
label variable p24 "Los productos agrícolas o la cría de animales en los que trabajó, fueron"
label variable p25 "En las últimas cuatro semanas, hizo alguna gestión para buscar trabajo y está disponible"
label variable p26 "Si no trabajó ni ha buscado trabajo"
label variable p27 "Ocupación o tarea que realiza"
label variable p28 "Actividad económica del negocio, empresa o lugar donde trabaja"
label variable p29 "Categoría de ocupación"
label variable p30 "Aporta actualmente"
label variable p31 "Estado conyugal"
label variable p3201 "Número de hijas nacidas vivas"
label variable p3202 "Número de hijos nacidos vivos"
label variable p3203 "Número de hijas e hijos nacidos vivos"
label variable p3301 "Número de hijas vivas actualmente"
label variable p3302 "Número de hijos vivas actualmente"
label variable p3303 "Número de hijas e hijos vivos actualmente"
label variable p34 "A qué edad tuvo su primera hija o hijo nacido vivo"
label variable p3501 "Día que tuvo su última hija o hijo nacido vivo"
label variable p3502 "Mes que tuvo su última hija o hijo nacido vivo"
label variable p3503 "Año que tuvo su última hija o hijo nacido vivo"
label variable id_per "Identificador de persona"
label variable gedad "Grupos de edad quinquenales"
label variable granedad "Grandes grupos de edad"
label variable etaedad "Grupos de edad por etapas de vida"
label variable dfunc "Dificultad funcional permanente"
label variable p10r "En que idioma o lenguas se comunica"
label variable analf "Condición de analfabetismo"
label variable condact "Condición de actividad (agregada)"
label variable condact1 "Condición de actividad (desagregada)"
label variable grupo1 "Grupo de ocupación (nivel 1)"
label variable rama1 "Rama de actividad (nivel 1)"
* Consolidated and improved value labels

label define yesno 1 "Sí" 2 "No", modify
label values h02 h0701 h0702 h0703 h0801 h0802 h1001-h1012 p05 p0601 p13 p15 p19 p20 p2101-p2104 v12 v16 imp_vopa yesno

label define exclusive_shared 1 "De uso exclusivo del hogar" 2 "Compartido con varios hogares" 3 "No tiene", modify
label values h03 h04 exclusive_shared

label define fuel_type 1 "Gas de tanque o cilindro" 2 "Gas centralizado (por tubería)" 3 "Electricidad" 4 "Leña o carbón" 5 "Biogás (residuos vegetales y/o animales, etc.)" 6 "Otro (Ej: gasolina, kerex, diésel, etc.)" 7 "Ninguno (no cocina)", modify
label values h05 fuel_type

label define water_treatment 1 "La beben, tal como llega al hogar" 2 "La compran (agua envasada en bidón, botella o funda)" 3 "La hierven" 4 "Le ponen cloro" 5 "La filtran (colocan filtros en el grifo o usan purificadores)" 6 "Realizan otro tratamiento", modify
label values h06 water_treatment

label define housing_tenure 1 "Propia y totalmente pagada" 2 "Propia y la está pagando" 3 "Propia (regalada, donada, heredada o por posesión)" 4 "Arrendada/anticresis" 5 "Prestada o cedida (no paga)" 6 "Por servicios", modify
label values h09 housing_tenure

label define yesno_unknown 1 "Sí" 2 "No" 9 "Se ignora", modify
label values h11 h12 h15 yesno_unknown

label define urban_rural 1 "Área Urbana" 2 "Área Rural", modify
label values aur urban_rural

label define bedroom_count 0 "Ninguno" 1 "Un dormitorio" 2 "Dos dormitorios" 3 "Tres dormitorios" 4 "Cuatro dormitorios" 5 "Cinco dormitorios" 6 "Seis o más dormitorios", modify
label values h01r bedroom_count

label define sex 1 "Hombre" 2 "Mujer", modify
label values p02 sex

label define doc_id 1 "Pasaporte u otro documento de identidad de su país de origen" 2 "No tiene documento alguno", modify
label values p0602 doc_id

label define difficulty_level 1 "No tiene dificultad" 2 "Alguna dificultad" 3 "Mucha dificultad" 4 "Total dificultad" 9 "Se ignora", modify
label values p0701-p0706 difficulty_level

label define location 1 "En esta ciudad o parroquia rural" 2 "En otro lugar del país" 3 "En otro país", modify
label values p08 location

label define residence5y 1 "En esta ciudad o parroquia rural" 2 "En otro lugar del país" 3 "En otro país" 4 "No había nacido", modify
label values p09 residence5y

label define ethnicity 1 "Indígena" 2 "Afroecuatoriana/o, Afrodescendiente, Negra/o, Mulata/o" 3 "Montubia/o" 4 "Mestiza/o" 5 "Blanca/o" 6 "Otro", modify
label values p11r ethnicity

label define school_type 1 "Fiscal (del Estado)" 2 "Particular (privado)" 3 "Fiscomisional" 4 "Municipal", modify
label values p16 school_type

label define education_level 1 "Ninguno" 2 "Centro de Desarrollo Infantil/Creciendo con nuestros hijos/Guardería" 3 "Educación inicial/Preescolar/SAFPI" 4 "Alfabetización/Post Alfabetización" 5 "Educación General Básica" 6 "Bachillerato" 7 "Ciclo Postbachillerato (No superior)" 8 "Educación Técnica o Tecnológica Superior" 9 "Educación Superior" 10 "Maestría/ Especialización" 11 "PHD/ Doctorado", modify
label values p17r education_level

label define work_status 1 "Trabajó al menos una hora para generar un ingreso" 2 "Realizó algún trabajo ocasional por un pago" 3 "Atendió un negocio propio" 4 "Ayudó en algún negocio o empleo de algún miembro de su hogar" 5 "No trabajó, pero SI tiene un trabajo al que seguro va a volver" 6 "Hizo o ayudó en labores agrícolas, cría de animales o pesca" 7 "No trabajó", modify
label values p22 work_status

label define agri_products 1 "Todo para la venta" 2 "La mayor parte para la venta" 3 "La mayor parte para consumo del hogar" 4 "Todo para consumo del hogar", modify
label values p24 agri_products

label define non_work_reason 1 "Es rentista" 2 "Es jubilada/o o pensionista" 3 "Es estudiante" 4 "Realiza quehaceres del hogar" 5 "Le impide trabajar su discapacidad" 6 "Otro", modify
label values p26 non_work_reason

label define occupation_category 1 "Empleada/o u obrera/o privado" 2 "Empleada/o u obrera/o del Estado, Gobierno, Municipio, Consejo Provincial, Junta Parroquial" 3 "Jornalera/o o peón" 4 "Empleada/o doméstica/o" 5 "Patrona/o" 6 "Cuenta propia" 7 "Socia/o" 8 "Trabajadora/or familiar no remunerada/o" 9 "Se ignora", modify
label values p29 occupation_category

label define social_security 1 "IESS Seguro General" 2 "IESS Seguro Voluntario" 3 "IESS Seguro Campesino" 4 "Seguro ISSFA" 5 "Seguro ISSPOL" 6 "No aporta, es Jubilada/o del IESS/ISSFA/ ISSPOL" 7 "No aporta" 9 "Se ignora", modify
label values p30 social_security

label define marital_status 1 "Unida/o" 2 "Separada/o" 3 "Divorciada/o" 4 "Viuda/o" 5 "Casada/o" 6 "Soltera/o", modify
label values p31 marital_status

label define age_groups 1 "Menor de 1 año" 2 "De 1 a 4 años" 3 "De 5 a 9 años" 4 "De 10 a 14 años" 5 "De 15 a 19 años" 6 "De 20 a 24 años" 7 "De 25 a 29 años" 8 "De 30 a 34 años" 9 "De 35 a 39 años" 10 "De 40 a 44 años" 11 "De 45 a 49 años" 12 "De 50 a 54 años" 13 "De 55 a 59 años" 14 "De 60 a 64 años" 15 "De 65 a 69 años" 16 "De 70 a 74 años" 17 "De 75 a 79 años" 18 "De 80 a 84 años" 19 "De 85 a 89 años" 20 "De 90 a 94 años" 21 "De 95 a 99 años" 22 "100 años o más", modify
label values gedad age_groups

label define large_age_groups 1 "De 0 a 14 años" 2 "De 15 a 64 años" 3 "65 años o más", modify
label values granedad large_age_groups

label define life_stages 1 "Niñas/os de 0 a 11 años" 2 "Adolescentes de 12 a 17 años" 3 "Jóvenes de 18 a 29 años" 4 "Adultas/os de 30 a 64 años" 5 "Adultas/os mayores de 65 años o más", modify
label values etaedad life_stages

label define functional_difficulty 1 "Con dificultad funcional" 2 "Sin dificultad funcional" 9 "Se ignora", modify
label values dfunc functional_difficulty

label define language 1 "Sólo idioma indígena" 2 "Sólo castellano/ español" 3 "Sólo idioma extranjero" 4 "Sólo lengua de señas ecuatoriana" 5 "No habla/ No se comunica" 6 "Idioma indígena y castellano/ español" 7 "Castellano/ español e idioma extranjero" 8 "Idioma indígena, castellano/ español e idioma extranjero" 9 "Otras combinaciones de idiomas", modify
label values p10r language

label define literacy 1 "Alfabeto" 2 "Analfabeto", modify
label values analf literacy

label define activity_condition 1 "Menor de 5 años" 2 "Fuerza de trabajo" 3 "Fuera de la fuerza de trabajo", modify
label values condact activity_condition

label define occupation_group 0 "Ocupaciones militares" 1 "Directores y gerentes" 2 "Profesionales científicos e intelectuales" 3 "Técnicos y profesionales del nivel medio" 4 "Personal de apoyo administrativo" 5 "Trabajadores de los servicios y vendedores de comercios y mercados" 6 "Agricultores y trabajadores calificados agropecuarios, forestales y pesqueros" 7 "Oficiales, operarios y artesanos de artes mecánicas y de otros oficios" 8 "Operadores de instalaciones y máquinas y ensambladores" 9 "Ocupaciones elementales" 99 "Se ignora", modify
label values grupo1 occupation_group

label define economic_activity 1 "Agricultura, ganadería, silvicultura y pesca" 2 "Explotación de minas y canteras" 3 "Industrias manufactureras" 4 "Suministro de electricidad, gas, vapor y aire acondicionado" 5 "Distribución de agua; alcantarillado; gestión de desechos y actividades de saneamiento" 6 "Construcción" 7 "Comercio al por mayor y al por menor; reparación de vehículos automotores y motocicletas" 8 "Transporte y almacenamiento" 9 "Actividades de alojamiento y de servicio de comidas" 10 "Información y comunicación" 11 "Actividades financieras y de seguros" 12 "Actividades inmobiliarias" 13 "Actividades profesionales, científicas y técnicas" 14 "Actividades de servicios administrativos y de apoyo" 15 "Administración pública y defensa; planes de seguridad social de afiliación obligatoria" 16 "Enseñanza" 17 "Actividades de atención de la salud humana y de asistencia social" 18 "Artes, entretenimiento y recreación" 19 "Otras actividades de servicios" 20 "Actividades de los hogares como empleadores" 21 "Actividades de organizaciones y órganos extraterritoriales" 99 "Se ignora", modify
label values rama1 economic_activity

label define housing_type 1 "Casa/villa" 2 "Departamento en casa o edificio" 3 "Cuarto/s en casa de inquilinato" 4 "Mediagua" 5 "Rancho" 6 "Covacha" 7 "Choza" 8 "Otra vivienda particular" 9 "Hotel, pensión, residencial u hostal" 10 "Cuartel militar, policía o bomberos" 11 "Centro de privación de libertad/cárcel" 12 "Hospital, clínica, etc." 13 "Convento o institución religiosa" 14 "Centro de acogida y protección para niñas/os y adolescentes" 15 "Residencia de adultos mayores/Asilo de ancianos" 16 "Internado de estudiantes" 17 "Campamento de trabajo" 18 "Otra vivienda colectiva" 19 "Sin vivienda", modify
label values v01 housing_type

label define occupation_status 1 "Ocupada con personas presentes" 2 "Ocupada con personas ausentes" 3 "De temporada o vacacional" 4 "Desocupada" 5 "En construcción", modify
label values v0201 occupation_status

label define occupation_status_r 1 "Ocupada" 2 "De temporada o vacacional" 3 "Desocupada" 4 "En construcción", modify
label values v0201r occupation_status_r

label define collective_occupation 1 "Con residentes habituales" 2 "Sin residentes habituales", modify
label values v0202 collective_occupation

label define roof_material 1 "Hormigón (losa, cemento)" 2 "Fibrocemento, asbesto (eternit, eurolit)" 3 "Zinc, aluminio (lámina o plancha metálica)" 4 "Teja" 5 "Palma, paja u hoja" 6 "Otro material", modify
label values v03 roof_material

label define condition 1 "Bueno" 2 "Regular" 3 "Malo", modify
label values v04 v06 v08 condition

label define wall_material 1 "Hormigón" 2 "Ladrillo o bloque" 3 "Panel prefabricado (yeso, fibrocemento, etc.)" 4 "Adobe o tapia" 5 "Madera" 6 "Caña revestida o bahareque" 7 "Caña no revestida" 8 "Otro material", modify
label values v05 wall_material

label define floor_material 1 "Duela, parquet, tablón o piso flotante" 2 "Cerámica, baldosa, vinil o porcelanato" 3 "Mármol o marmetón" 4 "Ladrillo o cemento" 5 "Tabla sin tratar" 6 "Caña sin tratar" 7 "Tierra" 8 "Otro material", modify
label values v07 floor_material

label define water_source 1 "Por tubería, dentro de la vivienda" 2 "Por tubería, fuera de la vivienda pero dentro del edificio, lote o terreno" 3 "Por tubería, fuera del edificio, lote o terreno" 4 "No recibe agua por tubería, sino por otros medios", modify
label values v09 water_source

label define water_provider 1 "Empresa Pública/Municipio" 2 "Juntas de Agua/Organizaciones comunitarias/GAD parroquial" 3 "Pozo" 4 "Carro o tanquero repartidor" 5 "Otras fuentes (río, vertiente, acequia, canal, grieta o agua lluvia)", modify
label values v10 water_provider

label define sanitation 1 "Inodoro o escusado, conectado a red pública de alcantarillado" 2 "Inodoro o escusado, conectado a pozo séptico" 3 "Inodoro o escusado, conectado a biodigestor" 4 "Inodoro o escusado, conectado a pozo ciego" 5 "Inodoro o escusado, con descarga directa al mar, río, lago o quebrada" 6 "Letrina" 7 "No tiene", modify
label values v11 sanitation

label define alt_energy 1 "Planta eléctrica (generador de luz)" 2 "Energía solar (panel fotovoltaico)" 3 "Energía eólica (a partir del viento)" 4 "Otra fuente (desechos vegetales y animales)" 5 "No dispone", modify
label values v13 alt_energy

label define garbage_disposal 1 "Por carro recolector" 2 "Por contenedor municipal" 3 "La arroja en terreno baldío" 4 "La quema" 5 "La entierra" 6 "La arroja al río, acequia, canal o quebrada" 7 "De otra forma", modify
label values v14 garbage_disposal
}




** Parameters for Identification
****************************************************
local level = 1  // Modify if want to use different level of OCC aggregation 1 (1dg) 2 (2dg) etc
****************************************************
local bw = .3 // Say 30% <- only modify this number. This is the THeoretical Share of "good matches"
****************************************************
local region i01  // Currently uses Provincia Level. You can choose other level to get "Avg Yrs of Education"
****************************************************

** Create Years of Education
** May need to be changed based on "official" code 
    gen byte aeduc = 0
    replace aeduc = 0                       if p17r==1       
    replace aeduc = 1                       if p17r==2       
    replace aeduc = p18r                    if p17r==3       
    replace aeduc = 2                       if p17r==4       
    replace aeduc = max(1,p18r)             if p17r==5                  
    replace aeduc = floor((p18r+1)/2)+10    if p17r==6                
    replace aeduc = p18r+12                 if p17r==7                
    replace aeduc = p18r+10                 if p17r==8                 
    replace aeduc = floor(p18r/2)+12        if p17r==9 & p18r>5        
    replace aeduc = p18r+12                 if p17r==9 & p18r<=5      
    replace aeduc = floor(p18r/2)+17        if p17r==10               
    replace aeduc = p18r+17                 if p17r==11                 
label var aeduc "Years of Education"
** Create Occupation Aggregation level
** Correcting errors in p27
replace p27 = p27 * 10 if p27<1000


capture drop occ_agg  
gen occ_agg = floor(p27/10^(4-`level'))
sum occ_agg, meanonly
replace occ_agg = . if    p27==9999
** Assume p27 will be ignored

** Analysis by region. For now assume Provincia
** Need to define criteria for "No mismatch" 
** Easiest, median Educ is the Correct level. But we should allow for bandwidth
** Theoretical share of PPL who are correctly matched


** This is under Non-normality
local bw_h = (0.5+`bw'/2)*100
local bw_l = (0.5-`bw'/2)*100
** under normality
local phi  = invnormal(0.5+`bw'/2)

** Regional Aggregation

bysort `region' occ_agg :egen mean_aeduc = mean(aeduc)
bysort `region' occ_agg :egen sd_aeduc = sd(aeduc)
bysort `region' occ_agg :gen mean_low   = mean_aeduc-`phi' *sd_aeduc
bysort `region' occ_agg :gen mean_high  = mean_aeduc+`phi' *sd_aeduc
** bajo el supuesto de non-normality
bysort `region' occ_agg :egen median_aeduc = median(aeduc)
bysort `region' occ_agg :egen qlow_aeduc   = pctile(aeduc), p(`bw_l')
bysort `region' occ_agg :egen qhigh_aeduc  = pctile(aeduc), p(`bw_h')

** Under education
gen skill_match_1 = 1 if (aeduc < mean_low )  & aeduc!=. & mean_aeduc!=. & occ_agg!=.
gen skill_match_2 = 1 if (aeduc < qlow_aeduc) & aeduc!=. & mean_aeduc!=. & occ_agg!=.

replace skill_match_1 = 2 if  inrange(aeduc,mean_low,mean_high)  & aeduc!=. & mean_aeduc!=. & occ_agg!=. 
replace skill_match_2 = 2 if inrange(aeduc,qlow_aeduc,qhigh_aeduc)  & aeduc!=. & mean_aeduc!=. & occ_agg!=.

replace skill_match_1 = 3 if (aeduc > mean_high) & aeduc!=. & mean_aeduc!=. & occ_agg!=.
replace skill_match_2 = 3 if (aeduc > qhigh_aeduc) & aeduc!=. & mean_aeduc!=. & occ_agg!=.
 
label define skill_match 1 "Under Educated"  2 "Match" 3 "Over Educated", modify
label values skill_match_1 skill_match_2 skill_match
