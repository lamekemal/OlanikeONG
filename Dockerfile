FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY Olanike/Olanike.csproj Olanike/
RUN dotnet restore Olanike/Olanike.csproj
COPY . .
WORKDIR /src/Olanike
RUN dotnet build Olanike.csproj -c $BUILD_CONFIGURATION -o /app/build


FROM build AS publish
RUN dotnet publish Olanike.csproj -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Olanike.dll"]