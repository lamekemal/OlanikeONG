FROM mcr.microsoft.com/dotnet/sdk:8.0 AS restore
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

COPY Olanike/Olanike.csproj Olanike/
RUN dotnet restore Olanike/Olanike.csproj

FROM node:alpine AS nodewass
WORKDIR /src
COPY . .
WORKDIR /src/Olanike
#RUN npm run tailwind

FROM restore AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
#COPY --from=nodetailwind /src .
WORKDIR /src/Olanike
RUN dotnet build Olanike.csproj -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish Olanike.csproj -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 8080
EXPOSE 8081
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Olanike.dll"]