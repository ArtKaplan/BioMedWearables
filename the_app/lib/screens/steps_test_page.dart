/*
class StepsTestPage extends StatelessWidget {
  const StepsTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Steps Debug")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<StepsProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.today),
                        label: const Text("Load Today"),
                        onPressed: () async {
                          await provider.updateTodaySteps();
                          print("Pressed today load");
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.bar_chart),
                        label: const Text("Load 2 Months"),
                        onPressed: () async {
                          await provider.load2MonthData();
                        },
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.medical_information),
                        label: const Text("Print patient list"),
                        onPressed: () async {
                          await Impact.printPatientsList();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Today's Steps",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child:
                      provider.getTodaySteps().isEmpty
                          ? const Center(child: Text("No steps for today"))
                          : ListView.builder(
                            itemCount: provider.getTodaySteps().length,
                            itemBuilder: (context, index) {
                              final step = provider.getTodaySteps()[index];
                              return ListTile(
                                title: Text(
                                  '${step.time.hour}:${step.time.minute.toString().padLeft(2, '0')}',
                                ),
                                trailing: Text('${step.value} steps'),
                              );
                            },
                          ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Steps Over Last 2 Months",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child:
                      provider.getStepsEachDay().isEmpty
                          ? const Center(child: Text("No steps loaded"))
                          : ListView.builder(
                            itemCount: provider.getStepsEachDay().length,
                            itemBuilder: (context, index) {
                              final dayStep = provider.getStepsEachDay()[index];
                              return ListTile(
                                title: Text(
                                  '${dayStep.day.toLocal()}'.split(' ')[0],
                                ),
                                trailing: Text('${dayStep.value} steps'),
                              );
                            },
                          ),
                ),
                const SizedBox(height: 20),
                const LogoutButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
*/