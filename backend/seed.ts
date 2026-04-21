import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "@prisma/client";
import { Pool } from "pg";

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

async function main() {
	await prisma.chatMessage.deleteMany();
	await prisma.chatParticipant.deleteMany();
	await prisma.chat.deleteMany();
	await prisma.class.deleteMany();
	await prisma.announcement.deleteMany();
	await prisma.menuItem.deleteMany();
	await prisma.order.deleteMany();
	await prisma.user.deleteMany();

	const staff = [
		"Raimund Weiss",
		"Tek Ming Ng",
		"Sing Ong Yu",
		"Aleksandar Ilic",
		"Andrew Tattersall",
		"Banchongsan Charoensook",
		"Byron Wright",
		"Chandan Mukherjee",
		"Chandara Koem",
		"Danet Hak",
		"Darin Duch",
		"David Tereladze",
		"Diana J. Haladay",
		"Donald Rallis",
		"Firend Alan Rasch",
		"Ilya Bystrov",
		"Janet Murphy",
		"Jesse Orndorff",
		"Joshua Wilwohl",
		"Kabin Antony",
		"Keneth Robinson",
		"Kenneth Lee Sutherland",
		"Ketsela Demissie",
		"Kiri San",
		"Kuntha Pin",
		"Leo Fernandez",
		"Limeng Ong",
		"Marc Piñol Rovira",
		"Mark Knapp",
		"Matthew Piscioneri",
		"Monyrath Buntoun",
		"Natalia Bianco",
		"Pisey Pin",
		"Prohim Tam",
		"Rose Lim",
		"Sarah Rose-Jensen",
		"Shad Ahmad Khan",
		"Shainima Islam",
		"Sophal Kao",
		"Sovannara Uk",
		"Stephen J. Ronzano",
		"Terence Joseph Mallon",
		"Theara Seng",
		"Tim Holland",
		"Walter Alexander Smith",
	];

	const users = [];
	for (let i = 0; i < staff.length; i++) {
		const user = await prisma.user.create({
			data: { id: `u${i + 1}`, name: staff[i] },
		});
		users.push(user);
	}

	await prisma.user.create({ data: { id: "s1", name: "kiritep vuthearith" } });
	await prisma.user.create({ data: { id: "s2", name: "tepprapey" } });

	const classes = [
		{
			id: "c1",
			name: "Business English",
			desc: "English for business communication",
			profId: "u1",
			day: "MO,WE",
			time: "02:00-03:30",
			room: "A201",
		},
		{
			id: "c2",
			name: "Computer Programming",
			desc: "Introduction to Python",
			profId: "u15",
			day: "MO,WE",
			time: "04:00-05:30",
			room: "Lab 301",
		},
		{
			id: "c3",
			name: "International Relations",
			desc: "Introduction to global politics",
			profId: "u33",
			day: "TU,TH",
			time: "02:00-03:30",
			room: "B102",
		},
		{
			id: "c4",
			name: "Marketing",
			desc: "Fundamentals of marketing",
			profId: "u5",
			day: "MO,WE",
			time: "08:00-09:30",
			room: "A101",
		},
		{
			id: "c5",
			name: "Data Structures",
			desc: "Algorithms and data structures",
			profId: "u18",
			day: "TU,TH",
			time: "08:00-09:30",
			room: "Lab 201",
		},
	];

	for (const c of classes) {
		await prisma.class.create({
			data: {
				id: c.id,
				name: c.name,
				desc: c.desc,
				profId: c.profId,
				schedule: {
					dtstart: `2026-04-20T${c.time.split("-")[0]}:00Z`,
					dtend: `2026-04-20T${c.time.split("-")[1]}:00Z`,
					rrule: `FREQ=WEEKLY;BYDAY=${c.day}`,
				},
				location: c.room,
			},
		});
	}

	const announcements = [
		{
			title: "Midterms",
			content: "Midterms start May 10. Please prepare accordingly.",
		},
		{
			title: "Exam Schedule",
			content: "Final exam schedule is now available on Canvas.",
		},
		{
			title: "Campus Closed",
			content: "Campus will be closed on Friday for national holiday.",
		},
		{
			title: "New Library Hours",
			content: "Library now opens until 9 PM on weekdays.",
		},
	];

	for (let i = 0; i < announcements.length; i++) {
		await prisma.announcement.create({
			data: { id: `a${i + 1}`, ...announcements[i] },
		});
	}

	const menuItems = [
		{ name: "Fried Rice", price: 2.5, qty: 50 },
		{ name: "Noodle Soup", price: 2.0, qty: 30 },
		{ name: "Sandwich", price: 1.5, qty: 20 },
		{ name: "Fried Chicken", price: 3.0, qty: 25 },
		{ name: "Pasta", price: 2.5, qty: 15 },
		{ name: "Salad", price: 1.8, qty: 20 },
		{ name: "Coffee", price: 1.0, qty: 100 },
		{ name: "Juice", price: 1.2, qty: 50 },
	];

	for (let i = 0; i < menuItems.length; i++) {
		await prisma.menuItem.create({
			data: { id: `m${i + 1}`, ...menuItems[i] },
		});
	}

	const chat1 = await prisma.chat.create({
		data: { id: "chat1", classId: "c1" },
	});
	await prisma.chatParticipant.create({
		data: { chatId: "chat1", userId: "u1" },
	});
	await prisma.chatParticipant.create({
		data: { chatId: "chat1", userId: "s1" },
	});
	await prisma.chatParticipant.create({
		data: { chatId: "chat1", userId: "s2" },
	});
	await prisma.chatMessage.create({
		data: {
			chatId: "chat1",
			from: "u1",
			message: "Welcome to Business English!",
		},
	});
	await prisma.chatMessage.create({
		data: { chatId: "chat1", from: "s1", message: "Good morning Professor!" },
	});

	const chat2 = await prisma.chat.create({
		data: { id: "chat2", classId: "c2" },
	});
	await prisma.chatParticipant.create({
		data: { chatId: "chat2", userId: "u15" },
	});
	await prisma.chatParticipant.create({
		data: { chatId: "chat2", userId: "s1" },
	});
	await prisma.chatMessage.create({
		data: {
			chatId: "chat2",
			from: "u15",
			message: "Bring your laptops tomorrow.",
		},
	});

	const chat3 = await prisma.chat.create({
		data: { id: "chat3", classId: "c3" },
	});
	await prisma.chatParticipant.create({
		data: { chatId: "chat3", userId: "u33" },
	});
	await prisma.chatParticipant.create({
		data: { chatId: "chat3", userId: "s2" },
	});
	await prisma.chatMessage.create({
		data: {
			chatId: "chat3",
			from: "s2",
			message: "When is the assignment due?",
		},
	});

	await prisma.order.create({
		data: {
			id: "o1",
			userId: "s1",
			items: [{ id: "m1", qty: 2 }],
			extraRequests: "Less oil",
		},
	});

	await prisma.order.create({
		data: {
			id: "o2",
			userId: "s2",
			items: [
				{ id: "m2", qty: 1 },
				{ id: "m3", qty: 1 },
			],
			extraRequests: "",
		},
	});

	console.log(
		`Seeded: ${users.length} staff, 2 students, ${classes.length} classes, ${announcements.length} announcements, ${menuItems.length} menu items, 3 chats with messages, 2 orders`,
	);
}

main();

