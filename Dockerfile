#Use official Node.js image
FROM mcr.microsoft.com/playwright:v1.54.2

#Install Java (required for Allure reports)
RUN apt-get update && \ 
apt-get install -y openjdk-11-jre && \
apt-get clean

#Set the working directory
WORKDIR /app

#Copy package.json and package-lock.json
COPY package*.json ./

#Install dependencies
RUN npm install

#Copy all project files
COPY . .

# Create directories for Allure results
RUN mkdir -p allure-results allure-report

# Run tests and generate report
CMD npx playwright test && \
    npx allure generate allure-results -o allure-report --clean

#Default command to run the tests
#CMD ["npx", "playwright", "test"]