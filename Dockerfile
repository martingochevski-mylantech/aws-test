# Use official node image as the base image
FROM node:latest as build

# Set the working directory
WORKDIR /usr/local/fe

# Add the source code to app
COPY ./angular-12-client /usr/local/fe/

# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN npm run build


# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=build /usr/local/fe/rc/app /usr/share/nginx/html

FROM node:latest
WORKDIR /usr/src/be
COPY ./node-js-server /usr/src/be
RUN npm install
RUN npm run build
