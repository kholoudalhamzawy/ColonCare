//
//  InfoTableViewController.swift
//  colonCancer
//
//  Created by KH on 25/04/2023.
//

import UIKit

class InfoTableViewController: UITableViewController {
    private let BackGroundView = backGroundView()

    func configureNavigationBar(){
        let ReminderView = UILabel()
        ReminderView.font = UIFont(name: "Poppins-Medium", size: 24)
        ReminderView.textColor = .label
        ReminderView.text = "Colon Cancer"
        navigationItem.titleView = ReminderView
        navigationItem.backButtonTitle = " "

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableView.backgroundView = BackGroundView
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)


      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  navigationController?.hidesBarsOnSwipe = true

    }

    // MARK: - Table view data source
    private var headers = ["ABOUT", "CAUSE", "SYMPTOMS", "TREATMENT"]
    private var info = [
        "Colon (colorectal) cancer starts in your colon (large intestine), the long tube that helps carry digested food to your rectum and out of your body. Colon cancer develops from certain polyps or growths in the inner lining of your colon..",
        
        "Doctors aren't certain what causes most colon cancers. In general, colon cancer begins when healthy cells in the colon develop changes (mutations) in their DNA. A cell's DNA contains a set of instructions that tell a cell what to do..",
        
        "Signs and symptoms of colon cancer include: A persistent change in your bowel habits, including diarrhea or constipation or a change in the consistency of your stool, Rectal bleeding or blood in your stool, Persistent abdominal discomfort..",
        
        "Surgery is the most common colon cancer treatment. There are different colon cancer surgeries and procedures، Polypectomy: This surgery removes cancerous polyps. Partial colectomy: This is also called colon resection surgery.."
    ]
    
    private var fullInfo = [
    """

Doctors aren't certain what causes most colon cancers.

In general, colon cancer begins when healthy cells in the colon develop changes (mutations) in their DNA. A cell's DNA contains a set of instructions that tell a cell what to do.

Healthy cells grow and divide in an orderly way to keep your body functioning normally. But when a cell's DNA is damaged and becomes cancerous, cells continue to divide — even when new cells aren't needed. As the cells accumulate, they form a tumor.

With time, the cancer cells can grow to invade and destroy normal tissue nearby. And cancerous cells can travel to other parts of the body to form deposits there (metastasis).

- Risk factors:
Factors that may increase your risk of colon cancer include:

Older age. Colon cancer can be diagnosed at any age, but a majority of people with colon cancer are older than 50. The rates of colon cancer in people younger than 50 have been increasing, but doctors aren't sure why.

African-American race. African-Americans have a greater risk of colon cancer than do people of other races.

A personal history of colorectal cancer or polyps. If you've already had colon cancer or noncancerous colon polyps, you have a greater risk of colon cancer in the future.

Inflammatory intestinal conditions. Chronic inflammatory diseases of the colon, such as ulcerative colitis and Crohn's disease, can increase your risk of colon cancer.

Inherited syndromes that increase colon cancer risk. Some gene mutations passed through generations of your family can increase your risk of colon cancer significantly. Only a small percentage of colon cancers are linked to inherited genes. The most common inherited syndromes that increase colon cancer risk are familial adenomatous polyposis (FAP) and Lynch syndrome, which is also known as hereditary nonpolyposis colorectal cancer (HNPCC).

Family history of colon cancer. You're more likely to develop colon cancer if you have a blood relative who has had the disease. If more than one family member has colon cancer or rectal cancer, your risk is even greater.

Low-fiber, high-fat diet. Colon cancer and rectal cancer may be associated with a typical Western diet, which is low in fiber and high in fat and calories. Research in this area has had mixed results. Some studies have found an increased risk of colon cancer in people who eat diets high in red meat and processed meat.

A sedentary lifestyle. People who are inactive are more likely to develop colon cancer. Getting regular physical activity may reduce your risk of colon cancer.

Diabetes. People with diabetes or insulin resistance have an increased risk of colon cancer.

Obesity. People who are obese have an increased risk of colon cancer and an increased risk of dying of colon cancer when compared with people considered normal weight.

Smoking. People who smoke may have an increased risk of colon cancer.

Alcohol. Heavy use of alcohol increases your risk of colon cancer.

Radiation therapy for cancer. Radiation therapy directed at the abdomen to treat previous cancers increases the risk of colon cancer.
""",
    """
    
    Signs and symptoms of colon cancer include:
    
    A persistent change in your bowel habits, including diarrhea or constipation or a change in the consistency of your stool, Rectal bleeding or blood in your stool, Persistent abdominal discomfort, such as cramps, gas or pain, A feeling that your bowel doesn't empty completely, Weakness or fatigue, Unexplained weight loss.
    
    Many people with colon cancer experience no symptoms in the early stages of the disease.
    When symptoms appear, they'll likely vary, depending on the cancer's size and location in your large intestine.
    """,
    """
         
        Colon (colorectal) cancer starts in your colon (large intestine), the long tube that helps carry digested food to your rectum and out of your body.

        Colon cancer develops from certain polyps or growths in the inner lining of your colon. Healthcare providers have screening tests that detect precancerous polyps before they can become cancerous tumors. Colon cancer that’s not detected or treated may spread to other areas of your body. Thanks to screening tests, early treatment and new kinds of treatment, fewer people are dying from colon cancer.

        How does this condition affect people?
        Your colon wall is made of layers of mucous membrane, tissue and muscle. Colon cancer starts in your mucosa, the innermost lining of your colon. It consists of cells that make and release mucus and other fluids. If these cells mutate or change, they may create a colon polyp.

        Over time, colon polyps may become cancerous. (It usually takes about 10 years for cancer to form in a colon polyp.) Left undetected and/or untreated, the cancer works its way through a layer of tissue, muscle and the outer layer of your colon. The colon cancer may also spread to other parts of your body via your lymph nodes or your blood vessels.

        Who is affected by colon cancer?
        Colon cancer is the third most common cancer diagnosed in people in the U.S. According to the U.S. Centers for Disease Control and Prevention (CDC), men and people assigned male at birth (AMAB) are slightly more likely to develop colon cancer than women and people assigned female at birth (AFAB). Colon cancer affects more people who are Black than people who are members of other ethnic groups or races.

        Colon cancer typically affects people age 50 and older. Over the past 15 years, however, the number of people age 20 to 49 with colon cancer has increased by about 1.5% each year. Medical researchers aren’t sure why this is happening.
        """
        ,
    """

Surgery is the most common colon cancer treatment. There are different colon cancer surgeries and procedures:
Polypectomy: This surgery removes cancerous polyps.

Partial colectomy: This is also called colon resection surgery. Surgeons remove the section of your colon that contains a tumor and some surrounding healthy tissue. They’ll reconnect healthy colon sections in a procedure called anastomosis.

Surgical resection with colostomy: Like a colectomy, surgeons remove the section of your colon that contains a tumor. In this surgery, however, they can’t connect healthy colon sections. Instead, they do a colostomy. In a colostomy, your bowel is moved to an opening in your abdominal wall so your poop is collected in a bag.

Radiofrequency ablation: This procedure uses heat to destroy cancer cells.

Healthcare providers may combine surgery with adjuvant therapy.

This is cancer treatment done before or after surgery. They may also use these treatments for colon cancer that has spread or come back.

Treatments may include:

Chemotherapy: Healthcare providers may use chemotherapy drugs to shrink tumors and ease colon cancer symptoms.

Targeted therapy: This treatment targets the genes, proteins and tissues that help colon cancer cells grow and multiply. Healthcare providers often use a type of targeted therapy called monoclonal antibody therapy. This therapy uses lab-created antibodies that attach to specific targets on cancer cells or cells that help cancer cells grow. The antibodies kill the cancer cells.

PREVENTION:

Can colon cancer be prevented?

You may not be able to prevent colon cancer, but you can reduce your risk of developing the condition by managing risk factors:

Avoid tobacco. If you smoke and want help quitting, talk to a healthcare provider about smoking cessation programs.

Use moderation when you drink beverages containing alcohol.

Maintain a healthy weight.

Eat a healthy diet. Add fruit and vegetables to your diet and cut back on red meat processed foods, and high-fat and high-calorie foods. Drinking coffee may lower your risk of developing colon cancer.

Keep track of your family medical history. Colon cancer can run in families. Tell your healthcare provider if your biological parents, siblings or children have colon cancer or an advanced polyp or if any of your family has cancer before age 45.

Follow colon cancer screening guidelines. Ask your healthcare provider when you should have colon cancer screening. If you have chronic irritable bowel disease or a family history of colon cancer, your healthcare provider may recommend you start screening earlier than age 45.
"""
    ]
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    //the height for the header above every section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font =  UIFont(name: "Poppins-Medium", size: 22)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = info[indexPath.row + indexPath.section]
            content.textProperties.color = .secondaryLabel
            content.textProperties.font =  UIFont(name: "Poppins-Regular", size: 16)!
            cell.contentConfiguration = content
            cell.backgroundColor = UIColor.clear
            cell.accessoryType = .disclosureIndicator
            return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = InfoViewController(header: headers[indexPath.section], body:  fullInfo[indexPath.row + indexPath.section]
)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc,
        animated: true)


    }


}

