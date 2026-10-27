# Builds the ATS-friendly resume PDF.
# Usage: python3 tools/resume/build_resume.py site/assets/files/Althaf_M_Resume.pdf
# Needs: pip install reportlab
# Edit the content below, rebuild, then check the PDF stays at 2 pages (pdfinfo).
import sys
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import mm
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.colors import HexColor
from reportlab.platypus import CondPageBreak, SimpleDocTemplate, Paragraph, Spacer, HRFlowable, ListFlowable, ListItem, KeepTogether
out=sys.argv[1]
INK=HexColor('#111111'); ACC=HexColor('#2F4F31'); MUT=HexColor('#444444')
name=ParagraphStyle('n',fontName='Helvetica-Bold',fontSize=20,leading=23,textColor=INK)
title=ParagraphStyle('t',fontName='Helvetica-Bold',fontSize=11.5,leading=15,textColor=ACC)
contact=ParagraphStyle('c',fontName='Helvetica',fontSize=9,leading=12.5,textColor=MUT)
h=ParagraphStyle('h',fontName='Helvetica-Bold',fontSize=10.5,leading=13,textColor=ACC,spaceBefore=9,spaceAfter=2,keepWithNext=1)
body=ParagraphStyle('b',fontName='Helvetica',fontSize=9.4,leading=12.6,textColor=INK)
role=ParagraphStyle('r',parent=body,fontName='Helvetica',spaceBefore=5,spaceAfter=1)
bul=ParagraphStyle('bl',parent=body)
def L(u,t): return f'<link href="{u}" color="#2F4F31">{t}</link>'
def sec(t):
    hr=HRFlowable(width='100%',thickness=0.6,color=ACC,spaceBefore=1,spaceAfter=4); hr.keepWithNext=1
    return [CondPageBreak(32*mm),Paragraph(t.upper(),h),hr]
def bullets(items): return ListFlowable([ListItem(Paragraph(i,bul),leftIndent=10,bulletColor=INK) for i in items],bulletType='bullet',start='•',leftIndent=10,bulletFontSize=8,spaceBefore=1)
def entry(left,right,items):
    return KeepTogether([Paragraph(f'{left} <font color="#444444">| {right}</font>',role),bullets(items)])
S=[]
S+= [Paragraph('ALTHAF M',name),Paragraph('Senior Full-Stack Engineer',title),
     Paragraph('Kozhikode, Kerala, India | +91 8086689184 | '+L('mailto:althafmdev@gmail.com','althafmdev@gmail.com'),contact),
     Paragraph('LinkedIn: '+L('https://linkedin.com/in/althafm2002','linkedin.com/in/althafm2002')+' | GitHub: '+L('https://github.com/AlthafMjeelani','github.com/AlthafMjeelani')+' | Portfolio: '+L('https://althafmjeelani.github.io/althaf-portfolio/','althafmjeelani.github.io/althaf-portfolio'),contact)]
S+=sec('Professional Summary')
S.append(Paragraph('Senior Full-Stack Engineer with 4+ years of experience designing, building and shipping production software across mobile, web, backend, cloud and AI. Delivered 13 products and 15+ apps on iOS, Android and web, including offline-first sales platforms, multi-tenant SaaS, multi-app service marketplaces, ERP and HR systems, fintech apps and multi-agent AI tools. Leads the engineering team at Texol World, owning architecture, CI/CD and releases. Experienced in Flutter, Go, Python, REST APIs, SQL and NoSQL databases, AWS, Docker, and LLM features using RAG and AI agents.',body))
S+=sec('Technical Skills')
sk=[('Languages','Dart, Go (Golang), Python, TypeScript, JavaScript, Kotlin, SQL'),
('Mobile &amp; Frontend','Flutter, iOS, Android, React, Next.js, Provider, Bloc, Riverpod, Clean Architecture, MVVM, Platform Channels, Responsive UI, Figma'),
('Backend &amp; APIs','REST APIs, GraphQL, Node.js, FastAPI, Microservices, Real-time Communication, Offline-first Sync, OAuth, JWT, Push Notifications (FCM)'),
('Databases','PostgreSQL, MongoDB, Redis, SQLite, Firebase Firestore'),
('AI &amp; Machine Learning','LLM Integration, Retrieval-Augmented Generation (RAG), Embeddings, Vector Search, AI Agents, Prompt Engineering, Fine-tuning, OCR &amp; Document Extraction, Speech Recognition &amp; Translation'),
('AI Tools &amp; Frameworks','OpenAI API, Claude API, Gemini, LangChain, LlamaIndex, Hugging Face, Ollama, Model Context Protocol (MCP), Pinecone, pgvector, PyTorch, TensorFlow'),
('Data Science &amp; Engineering','Pandas, NumPy, scikit-learn, Jupyter, ETL/ELT, Data Warehousing, Snowflake, BigQuery, Amazon Redshift, dbt, Apache Airflow, Apache Spark, Kafka, Power BI, Looker'),
('Cloud &amp; DevOps','AWS, Google Cloud, Azure, Docker, Kubernetes, Terraform, CI/CD, GitHub Actions, Linux, Nginx, Git'),
('Security &amp; Payments','API Security, OWASP, IAM, Biometric Authentication, Apple Pay, Telr, PhonePe, UPI, Wallet Systems'),
('Practices','Agile/Scrum, Code Review, Unit &amp; Integration Testing, Debugging, Performance Optimization, Team Leadership')]
for k,v in sk: S.append(Paragraph(f'<b>{k}:</b> {v}',ParagraphStyle('sk',parent=body,spaceAfter=1.5)))
S+=sec('Professional Experience')
S.append(entry('<b>Senior Full-Stack Engineer</b>','Texol World, Kozhikode, Kerala | Jan 2024 – Present',[
'Lead the engineering team across mobile, web, backend, cloud and AI, owning the full lifecycle from analysis and architecture to deployment.',
'Top contributor to Vanforces, a route-to-market SaaS: about 1,900 commits on the offline-first Flutter app since Jan 2024 and 826 on the React admin portal, plus Go backend work (Gin, MySQL, Redis).',
'Delivered DHG Car Wash, a suite of 3 connected apps (Customer, Shop, Operator) with Apple Pay, Telr and wallet payments.',
'Shipped Speak Order, a multi-language voice ordering app with AI speech recognition and real-time translation.',
'Built Taskforces ERP and WorkForceTime, covering inventory, invoicing, collections, QR/GPS attendance, shifts and payroll.',
'Set up CI/CD with GitHub Actions for automated builds, testing and App Store / Google Play releases.',
'Recognised as Employee of the Month multiple times for project delivery and innovation.']))
S.append(entry('<b>Flutter Developer</b>','BigWelt Infotech Pvt. Ltd., Bangalore, Karnataka | Dec 2022 – Dec 2023',[
'Developed cross-platform iOS and Android apps with optimised state management and clean architecture.',
'Built AGSKart, a recharge and bill payment app with PhonePe gateway, biometric authentication and push notifications.',
'Collaborated with backend and UI/UX teams to integrate REST APIs and deliver responsive interfaces.']))
S.append(entry('<b>Flutter Developer Intern</b>','Brototype, Kozhikode, Kerala | May 2022 – Dec 2022',[
'Delivered client projects from concept to deployment, including an e-commerce app.',
'Applied state management, performance optimisation and release best practices.']))
S+=sec('Key Projects')
S.append(entry('<b>PayNest – Multi-tenant Payments SaaS</b>','Go, PostgreSQL, Redis, React, TypeScript, AWS, Kubernetes | Mar 2026 – Aug 2026',[
'Built the Go backend and React/TypeScript admin apps (about 670 commits) serving a platform console, tenant portal and Flutter customer app.',
'Database-per-tenant PostgreSQL with automated provisioning; RS256 JWT, refresh tokens, TOTP 2FA and role-based access.',
'Redis + Asynq background jobs, SendGrid, Twilio and AWS S3; Docker, Kubernetes/Helm and GitHub Actions CI/CD.']))
S.append(entry('<b>AI Frontier – Multi-agent AI Release Tracker</b>','Go, Flutter, PostgreSQL, LLMs, Docker | Oct 2026',[
'Six-agent pipeline (discovery, verification, report, relevance, mission, evidence) behind one provider router for OpenAI, Claude, Gemini, Mistral, Groq and Ollama.',
'Prompt-injection defence by isolating source text as untrusted data; API keys encrypted at rest; Go API, worker and scheduler.']))
S.append(entry('<b>Order Extract – AI Document Extraction</b>','Flutter, ML Kit OCR, Claude API, Node.js, SQLite | Oct 2026',[
'Reads orders and invoices from PDF, Excel, CSV or photos with on-device OCR and a Claude fallback returning schema-validated JSON.',
'Fuzzy-matches every line to items, customers, routes and salesmen with confidence scores for review.']))
S.append(entry('<b>Vanforces – Van Sales &amp; Distribution Platform</b>','Flutter, React, Go, MySQL, Redis, SQLite, Google Maps',[
'Offline-first app with two-way SQLite sync, so field sales continue without network coverage.',
'Google Maps routing, live stock management and Bluetooth ESC/POS receipt printing.',
'Live on '+L('https://apps.apple.com/in/app/vanforces/id6741518174','App Store')+' and '+L('https://play.google.com/store/apps/details?id=com.vanforces.salesman.app','Google Play')+'.']))
S.append(entry('<b>DHG Car Wash – Car Wash Management Suite</b>','Flutter, REST API, Apple Pay, Telr',[
'Three interconnected apps with role-based access and location-based service allocation.',
'Apple Pay, Telr and custom wallet payments, plus commission and booking management.']))
S.append(entry('<b>Speak Order – AI Voice Ordering Platform</b>','Flutter, REST API, AI Speech, Translation',[
'Voice ordering in multiple languages with automatic translation for cross-language chat.',
'Geo-based business discovery and integrated payments. Live on '+L('https://apps.apple.com/in/app/speak-order/id6738990670','App Store')+' and '+L('https://play.google.com/store/apps/details?id=com.texol.speakorder','Google Play')+'.']))
S.append(entry('<b>More shipped apps</b>','Flutter, REST APIs',[
'Taskforces ERP (inventory, invoicing, collections) and WorkForceTime (QR/GPS attendance, shifts, payroll) at Texol World.',
'AGSKart recharge and bill payments with PhonePe and biometric login at BigWelt.']))
S+=sec('Education')
S.append(Paragraph('<b>Bachelor of Computer Applications (BCA)</b> <font color="#444444">| MET Arts and Science College, Nadapuram – Calicut University | Jun 2019 – Mar 2022</font>',ParagraphStyle('e',parent=body,spaceAfter=3)))
S.append(Paragraph('<b>Higher Secondary Education</b> <font color="#444444">| GHSS Avala Kuttoth, Kozhikode | Jun 2017 – Mar 2019</font>',body))
S+=sec('Achievements')
S.append(bullets(['Employee of the Month at Texol World, awarded multiple times for outstanding project delivery and innovation.',
'Top contributor to the Vanforces mobile app (about 1,900 commits) and admin portal (826 commits).']))
S+=sec('Languages')
S.append(Paragraph('English, Malayalam, Hindi, Tamil',body))
doc=SimpleDocTemplate(out,pagesize=A4,leftMargin=16*mm,rightMargin=16*mm,topMargin=14*mm,bottomMargin=14*mm,
  title='Althaf M - Senior Full-Stack Engineer - Resume',author='Althaf M',subject='Resume',keywords='Senior Full-Stack Engineer, Flutter, Go, Python, AWS, RAG, AI')
doc.build(S)
