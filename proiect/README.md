# Instalare Backend

Pentru instalarea componentei de Backend utilizatorul trebuie să instaleze Node.js. După ce a fost instalat Node.js se crează un director nou și se rulează următoarele comenzi în terminal:

npm init   
npm install
npm install express
npm install mongoose
npm install cors   
npm install dotenv
npm install jsonwebtoken
npm install bcrypt
npm install joi
npm install nodemailer
npm install multer

După ce au fost folosite aceste comenzi, se copiază fișierele din directorul e-Lawyer - Backend în directorul în care se dorește rularea codului și se folosește comanda: node index.js

# Instalare Frontend

Pentru instalarea componentei de Frontend utilizatorul trebuie să instaleze Flutter și Android SDK. După ce a fost instalat Flutter se crează un director nou și se rulează următoarele comenzi în terminal:

flutter create first_app
start ms-settings:developers

După ce au fost rulate aceste comenzi, se copiază fișierele din directorul e-Lawyer - Frontend în directorul în care se dorește rularea codului. Este necesară utilizarea unei mașini virtuale pentru Android. După ce a fost legată mașina virtuală se rulează următoarele comenzi:

flutter build apk
flutter run