# AgentServe — Agentic AI Service Orchestrator

This project simulates an **Agentic AI System for the informal economy**, automating the end-to-end lifecycle of a home service request using AI-powered orchestration.

## Core Capabilities

The application uses an AI-powered service orchestration layer to manage the complete agent workflow:

* **Orchestrate agent workflows:** The `AgentService` serves as the central brain, orchestrating the lifecycle: **Intent → Discovery → Reasoning → Booking → Notification**.
* **Manage multi-step reasoning:** The agent evaluates multiple variables, including provider proximity, ratings, availability, and schedule, to determine the best service provider. This process is demonstrated through the **Agent Reasoning Logs** panel in the UI.
* **Integrate external tools:** The workflow simulates integration with external tools such as Maps, Search APIs, and service-provider APIs for location resolution and local provider discovery.
* **Execute actions:** The system simulates booking transactions, generates confirmation IDs, and triggers automated notifications as follow-up actions.

## Architecture

The application follows **Clean Architecture**:

* **Domain Layer:** Contains the core entities such as `ServiceRequest`, `Provider`, `Booking`, and `WorkflowLog`.
* **Data Layer:** Contains mock datasets and the `AgentService`, powered by AI for reasoning and natural language processing.
* **Application Layer:** Uses `flutter_riverpod`state management (`Notifier`) to manage application state and drive the multi-step agent workflow.
* **Presentation Layer:** Provides a responsive Flutter UI with a conversational Input for service requests and a live Log Panel for observing the agent's decision-making and workflow execution.

## How to Run

1. Create a `.env` file in the project root.
2. Add your Gemini API key:

```env
GEMINI_API_KEY=ADD_GEMINI_API_KEY_HERE
```

3. Add your Maps API key:

```env
MAP_API_KEY=ADD_MAP_API_KEY_HERE
```
4. Add the updated Gemini model and enable Gemini AI:

```env
GEMINI_MODEL=gemini-3.7-flash
GEMINI_ENABLED=true
```
5. Install dependencies and run the application:

```bash
flutter pub get
flutter run
```

6. Try natural-language requests in **English, Urdu, or Roman Urdu**, for example:

> "I need an AC technician in G-13, Islamabad tomorrow morning.", 

> "Mujhe kal subah G-13 Islamabad mein AC technician chahiye."

## Assumptions & Limitations

* The AI orchestration layer uses the **Google Gemini API** to perform reasoning, natural-language understanding, and decision-making.
* Local service providers are mocked, simulating provider discovery within a realistic search radius.
* Bookings and notifications are simulated with deliberate delays to represent interactions with external APIs.
* The application updates the UI throughout the workflow, allowing users to observe the agent's reasoning, provider selection, booking process, and notification events.

## Project Goal

**AgentServe** demonstrates how Agentic AI can automate traditionally manual service-request workflows by understanding user intent, discovering suitable providers, reasoning over multiple options, executing actions, and keeping users informed throughout the process.
